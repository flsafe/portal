class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student
  before_action :set_student

  def show
    @student = current_user
    @opportunities = Opportunity.includes(:company).order(created_at: :desc).limit(25)
    @applications = Application.includes(opportunity: [:company]).where(user: current_user).order(created_at: :desc).limit(25)
    @application_opportunity_ids = @applications.map{|app| app.opportunity.id}
  end

  def set_student
    @student = Student.find(params[:id])
    return if current_user.admin_or_staff?
    redirect_home(current_user) unless @student == current_user
  end
end