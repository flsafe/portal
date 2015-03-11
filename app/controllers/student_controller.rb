class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student
  before_action :set_student

  def show
    @student = current_user
    @companies = Company.includes(:opportunities).order(created_at: :desc).limit(25)
  end

  def set_student
    @student = Student.find(params[:id])
    return if current_user.admin_or_staff?
    redirect_home(current_user) unless @student == current_user
  end
end