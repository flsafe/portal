module UserHomePage
  extend ActiveSupport::Concern

  private

  def redirect_home(user)
    redirect_to user_home_url(user)
  end

  def user_home_url(user)
    case
    when user.nil?
      root_url
    when user.admin?
      admin_root_url
    when user.staff? 
      staff_dashboard_url
    when user.employer? 
      company_url(user.company.slug)
    when user.student?
      student_home_url
    else
      raise "Unknown user type #{user.type}"
    end
  end
end