require 'redcarpet'

class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student
  before_action :set_student
  before_action :ensure_student_profile_complete, except: [:edit_profile, :update_profile]

  def home
    @companies = Company.includes(:opportunities).order(created_at: :desc).limit(25)
  end

  def edit_profile
  end

  def update_profile
    if current_user.update(student_params)
      redirect_to student_home_url, flash: {success: 'Your profile has been updated.'}
    else
      render :edit_profile
    end
  end

  def applications
    @applications = current_user.applications.includes(opportunity: [:company]).limit(25)
  end

  def application
    @application = Application.find(params[:id])
    redirect_home(current_user) unless current_user.applications.include?(@application)
  end

  def new_application
    @opportunity = Opportunity.find(params[:id])
    @application = @opportunity.applications.build()
  end

  def create_application
    @opportunity = Opportunity.find(params[:id])
    @application = @opportunity.applications.build(application_params) 
    @application.user = current_user

    respond_to do |format|
      if @application.save
        format.html { redirect_to student_home_url, flash: {success: "You have submitted your application for #{@opportunity.title}!" }}
      else
        format.html { render :new_application }
      end
    end
  end

  def edit_application
    @application = Application.includes(:opportunity).find(params[:id])
    @opportunity = @application.opportunity
  end

  def update_application
    @application = Application.includes(:opportunity).find(params[:id])
    @opportunity = @application.opportunity

    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to student_applications_path, flash: {success: "You have updated your application for #{@opportunity.title}!"} }
      else
        format.html { render :new }
      end
    end
  end

  def show_opportunity
    @md = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @opportunity = Opportunity.find(params[:id])
  end

  private

  def set_student
    @student = current_user 
  end

  def ensure_student_profile_complete
    redirect_to(edit_student_profile_url, flash: {notice: 'Welcome! Please complete your profile before continuing.'}) unless current_user.valid?
  end

  def application_params
    params.require(:application).permit(:cover_letter, :resume)
  end

  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation, :avatar,  :first_name, :last_name, :phone, :bio, :address1, :city, :state, :zip)
  end
end