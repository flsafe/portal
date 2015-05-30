require 'redcarpet'

class StaffController < ApplicationController

  before_action :ensure_staff
  before_action :set_staff_campuses
  before_action :ensure_campus_belongs_to_staff, only: [:students]
  before_action :ensure_student_belongs_to_staff, only: [:inbox_edit_student_placement_profile,
                                                         :edit_student_placement_profile,
                                                         :student_placement_profile,
                                                         :new_recommendation,
                                                         :student_resume,
                                                         :toggle_opportunity_recommendation]

  def edit_profile
  end

  def update_profile
    if current_user.update(staffer_params)
      redirect_to user_home_url(current_user), notice: 'Updated profile.'
    else
      render :edit_profile
    end
  end

  def dashboard
  end

  def events
    set_staff_inbox_counts
    set_inbox_applications
  end

  def application
    @md = Redcarpet::Markdown.new(Redcarpet::Render::HTML) 
    @application = Application.through_partners(current_user.school).includes(:opportunity, :student).find(params[:id])
    @student = @application.student
    @opportunity = @application.opportunity
  end

  def application_action
    @application = Application.through_partners(current_user.school).find(params[:id])
    if params[:application_action].eql? :approve
      @application.approve(current_user)
    elsif params[:application_action].eql? :reject
      @application.reject(current_user)
    end
    respond_to do |format| 
      if @application.save
        ApplicationMessage.create!(school: current_user.school, application: @application)
        set_staff_inbox_counts
        set_inbox_applications
        format.html { redirect_to staff_home_url }
        format.js
      else
        format.html { redirect_to staff_home_url }
        format.js{ render status: 400 } 
      end
    end
  end

  def inbox_edit_student_placement_profile
    set_staff_inbox_counts
    @application = @student.applications.includes(opportunity: :company).find(params[:application_id])
    @events = @application.application_events
    self.session_redirect = staff_inbox_edit_student_placement_profile_url(@student, @application)
  end

  # TODO: Actually set the current student profile and authorize the access.
  # this is currently ignored for prototyping.
  def new_auto_follow_up
  end

  def tasks
  end

  def activity
    @activity_messages = current_user.school.activity_messages
                                            .paginate(page: params[:page], per_page: 25)
  end

  def recomendations
  end

  def opportunity
    @md = Redcarpet::Markdown.new(Redcarpet::Render::HTML) 
    @opportunity = Opportunity.through_partners(current_user.school).where(id: params[:id]).first()
  end

  def opportunities
    @opportunities = Opportunity.through_partners(current_user.school)
                                .includes(:applications)
                                .includes(:employer)
                                .paginate(page: params[:page], per_page: 10)
  end

  def opportunity_applications
    @opportunity = Opportunity.through_partners(current_user.school)
                              .find(params[:id])
    @applications = @opportunity.applications.paginate(page: params[:page], per_page: 12).includes(:student)
    @recommended_applications = Application.includes(:student)
                                           .joins(:opportunity)
                                           .where(opportunity_id: @opportunity)
                                           .where(id: current_user.application_recommendations.pluck(:application_id))
                                           .limit(30)
  end

  def opportunity_recommendations
    @opportunity = Opportunity.through_partners(current_user.school)
                              .find(params[:id])
    @opportunity_recommendations = current_user.opportunity_recommendations
                                               .where(opportunity: @opportunity)
                                               .includes(:student, :opportunity)
    @recommended_students = @opportunity_recommendations.map(&:student)
    set_filtered_students
  end

  def toggle_opportunity_recommendation
    @opportunity = Opportunity.through_partners(current_user.school).find(params[:opportunity_id])
    @recommendation = current_user.opportunity_recommendations.includes(:student, :opportunity)
                                                              .find_by(opportunity: @opportunity, student: @student)
    if @recommendation
      @recommendation.destroy
      @recommendation = nil
    else
      OpportunityRecommendationMessage.create!(school: current_user.school,
                                               staffer: current_user,
                                               opportunity: @opportunity,
                                               student: @student) 
      @recommendation = current_user.opportunity_recommendations.create!(staffer: current_user,
                                                                         opportunity: @opportunity,
                                                                         student: @student)
    end
    @opportunity_recommendations = current_user.opportunity_recommendations
                                               .includes(:student)
                                               .where(opportunity: @opportunity)
    @recommended_students = @opportunity_recommendations.map(&:student)
    respond_to do |format|
      format.js
    end
  end

  def toggle_application_recommendation
    @application = Application.through_partners(current_user.school).includes(:opportunity).find(params[:id])
    @opportunity = @application.opportunity
    @recommendation = current_user.application_recommendations.find_by(application_id: @application.id)
    if @recommendation
      @recommendation.destroy
      @recommendation = nil
    else
      @recommendation = current_user.application_recommendations.create!(application: @application)
      ApplicationRecommendationMessage.create!(school: current_user.school,
                                               staffer: current_user,
                                               application: @application)
    end
    @recommended_applications = Application.includes(:student)
                                            .where(id: current_user.application_recommendations.pluck(:application_id),
                                                   opportunity: @opportunity)
    respond_to do |format|
      format.js
    end
  end

  def team
    @employers = current_user.school.partnerships.includes(:employer).map(&:employer)
  end

  def new_team_member
    @invite = Invite.new
    @companies = Company.all
  end

  def team_invites
  end

  def create_team_member
    @invite = Invite.new(invite_params.merge(invite_type: 'Employer',
                                             school_id: current_user.school.id))
    if @invite.save
      InviteMailer.send_invite(@invite).deliver
      redirect_to staff_team_path, notice: "Invite sent."
    else
      @companies = Company.all
      render :new_team_member
    end
  end

  def delete_team_member
    partnership = current_user.school.partnerships.find_by!(employer_id: params[:id])
    partnership.destroy
    redirect_to staff_team_path, notice: 'The recruiter has been removed'
  end

  def campuses
    # Campus actions are handled by the admin/campus controller
    # we want to redirect back here from that controller.
    self.session_redirect = staff_campuses_url
  end

  def students
    set_filtered_students  
  end

  def new_student
    @invite = Invite.new
  end

  def create_student
    @invite = Invite.new(invite_params.merge(invite_type: 'Student'))
    if @invite.save
      InviteMailer.send_invite(@invite).deliver
      redirect_to staff_students_url, notice: "We've sent out the student invite."
    else
      render :new_student 
    end
  end

  def invites
    @campus_ids = @campuses.map(&:id)
    @invites = Invite.where(campus_id: @campus_ids).paginate(page: params[:page], per_page: 20)
  end

  def delete_invite
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to staff_invites_path, notice: "Deleted #{@invite.email}"
  end

  def student_resume
  end

  def student_placement_profile
    @applications = @student.applications.includes(:application_events, opportunity: [:company, :employer])
  end

  def edit_student_placement_profile
    @application = @student.applications.includes(:application_events, opportunity: :company).find(params[:application_id])
    @events = @application.application_events
    self.session_redirect = staff_edit_student_placement_profile_url(@student, @application)
  end

  def create_student_placement_event
    @application = Application.includes(:student).find(params[:application_id])
    @student = @application.student
    if @event = @application.application_events.create(event_params.merge(staffer: current_user))
      ApplicationEventMessage.create!(school: current_user.school,
                                      application: @application,
                                      staffer: current_user,
                                      application_event: @event)
      redirect_to_session_or(staff_edit_student_placement_profile_url(@student, @application), flash: {success: "Note Added"})
    else
      render 'edit_student_placement_profile'
    end
  end

  def destroy_student_placement_event
    @event = ApplicationEvent.includes(application: :student).find(params[:event_id])
    @application = @event.application
    @student = @application.student
    ApplicationEventMessage.find_by!(application_event: @event).destroy!
    @event.destroy!
    @events = @application.application_events
    respond_to do |format|
      format.html {
        redirect_to_session_or(staff_edit_student_placement_profile_url(@student, @application), flash: {success: "Note Deleted"})
      }
      format.js
    end
  end

  def update_student_placement_profile
  end

  def new_recommendation
  end

  def companies
    @companies = Company.order(:name).paginate(page: params[:page], per_page: 20)
    self.session_redirect = staff_companies_url
  end

  private

  def set_staff_inbox_counts
    @pending_count = Application.through_partners(current_user.school).pending.count
    @archived_count = Application.through_partners(current_user.school).approved.count
    @rejected_count = Application.through_partners(current_user.school).rejected.count
  end

  def set_filtered_students
    @campus = @campuses.find_by(id: params[:campus_id]) || @campuses.find{|c| c.city =~ /#{current_user.city}/i} || @campuses.first
    @year = (params[:year] || Date.today.year).to_i
    @semester = params[:semester] || Student.current_semester
    @students = Student.where(campus_id: @campus,
                              year: @year,
                              semester: Student.semesters[@semester])
                       .order(:last_name, :first_name)
                       .paginate(page: params[:page], per_page: 10)
  end

  def set_inbox_applications
    @active_button = params[:type] || 'pending'
    @applications = if @active_button.eql? 'archived'  # Approved applications are archived
                      Application.through_partners(current_user.school)
                                 .includes(:student, opportunity: :company)
                                 .approved
                                 .paginate(page: params[:page], per_page: 12)
                    elsif @active_button.eql? 'rejected'
                      Application.through_partners(current_user.school)
                                 .includes(:student, opportunity: :company)
                                 .rejected
                                 .paginate(page: params[:page], per_page: 12)
                    else
                      Application.through_partners(current_user.school)
                                 .includes(:student, opportunity: :company)
                                 .pending
                                 .paginate(page: params[:page], per_page: 12)
                    end
  end

  def ensure_student_belongs_to_staff
    @student = Student.includes(:campus).find(params[:id])
    redirect_to(staff_home_url) unless @campuses.include?(@student.campus)
  end

  def ensure_campus_belongs_to_staff
    if params[:campus_id]
      redirect_to(staff_home_url) unless @campuses.find_by(id: params[:campus_id])
    end
  end

  def set_staff_campuses
    @campuses = current_user.school.campuses.order(:name).all()
  end

  def staffer_params
    params.require(:staffer).permit(:email, :password, :password_confrimation, :first_name, :last_name, :avatar, :city, :state)
  end

  def invite_params
    params.require(:invite).permit(:email, :semester, :year, :campus_id, :company_id)
  end

  def event_params
    params.require(:application_event).permit(:title, :event_date, :notes, :description)
  end
end
