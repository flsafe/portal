class Employer::StudentsController < EmployerPortalController
  layout 'employer'

  def index 
    @students = Student.school_directories(current_user.schools.pluck(:id))
  end

  def show
  end
end