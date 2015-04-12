class StaffController < ApplicationController

  before_action :ensure_staff
  before_action :ensure_staff_student, only: [:student_applications] 

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
    @campuses = current_user.school.campuses
  end

  def students
    @students = Student
                  .joins(campus: :school)
                  .where(campuses: {school_id: current_user.school_id})
                  .paginate(page: params[:page], per_page: 20)
  end

  def new_student
    @student = Student.new
    @campuses = current_user.school.campuses
  end

  def create_student
    redirect_to staff_students_url, notice: "We've sent out the student invite."
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