module UserHomePage
  extend ActiveSupport::Concern

  private

  def redirect_home(user)
    case
    when user.admin?
      redirect_to admin_root_url
    when user.staff? 
      redirect_to admin_school_url(user.school)
    when user.employer? 
      redirect_to company_url(user.company.slug)
    when user.student?
      redirect_to student_url(current_user)
    else
      raise "Unknown user type #{user.type}"
    end
  end
end