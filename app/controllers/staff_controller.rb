class StaffController < ApplicationController

  before_action :ensure_staff
  before_action :set_staff_campuses
  before_action :ensure_student_belongs_to_staff, only: [:student_placement_profile, :new_recommendation] 

  def edit_profile
  end

  def update_profile
    if current_user.update(staffer_params)
      redirect_to user_home_url(current_user), notice: 'Updated profile.'
    end
  end

  def dashboard
  end

  def messages
  end

  # TODO: Actually set the current student profile and authorize the access.
  # this is currently ignored for prototyping.
  def inbox_profile
  end

  # TODO: Actually set the current student profile and authorize the access.
  # this is currently ignored for prototyping.
  def new_auto_follow_up
  end

  def tasks
  end

  def activity
  end

  def recomendations
  end

  def opportunities
  end

  def team
  end

  def campuses
    # Campus actions are handled by the admin/campus controller
    # we want to redirect back here from that controller.
    self.session_redirect = staff_campuses_url
  end

  def students
    @campus = params[:campus_id] ? @campuses.find{|c| c.id.to_s == params[:campus_id]} : @campuses.first
    @students = Student.where(campus_id: @campus.id)
                       .order(:last_name, :first_name)
                       .paginate(page: params[:page], per_page: 20)
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
    @invites = Invite.where(campus_id: @campus_ids)
  end

  def delete_invite
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to staff_invites_path, notice: "Deleted #{@invite.email}"
  end

  def student_placement_profile
  end

  def edit_student_placement_profile
  end

  def update_student_placement_profile
  end

  def new_recommendation
  end

  private

  def ensure_student_belongs_to_staff
    @student = Student.includes(:campus).find(params[:id])
    unless current_user.admin?
      redirect_to(staff_home_url) unless @campuses.include?(@student.campus)
    end
  end

  def set_staff_campuses
    @campuses = current_user.school.campuses.order(:name).all()
  end

  def staffer_params
    params.require(:staffer).permit(:email, :password, :password_confrimation, :avatar, :city, :state)
  end

  def invite_params
    params.require(:invite).permit(:email, :semester, :year, :campus_id)
  end
end