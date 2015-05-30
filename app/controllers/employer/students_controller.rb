class Employer::StudentsController < EmployerPortalController
  def index 
    @students = Student.school_directories(current_user.schools.pluck(:id))
  end

  def show
    @student = Student.find(params[:id])
  end
end