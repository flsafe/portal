class StaffController < ApplicationController

  before_action :ensure_staff
  before_action :ensure_staff_student, except: [:home, :students]

  def home
  end

  def students
    @students = Student
                  .joins(:school)
                  .includes(:school)
                  .where(school: current_user.school)
                  .paginate(page: params[:page], per_page: 20)
  end

  def student_applications
  end

  def new_recommendation
  end

  private

  def ensure_staff_student
    @student = Student.includes(:school).find(params[:id])
    unless current_user.admin?
      redirect_to(staff_home_url) unless @student.school == current_user.school
    end
  end

end