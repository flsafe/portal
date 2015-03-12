class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student
  before_action :set_student

  def show
    @companies = Company.includes(:opportunities).order(created_at: :desc).limit(25)
  end

  def applications
    @applications = @student.applications.joins(:companies).limit(25)
  end

  private

  def set_student
    @student = Student.find(params[:id] || params[:student_id])
    return if current_user.admin_or_staff?
    redirect_home(current_user) unless @student == current_user
  end
end