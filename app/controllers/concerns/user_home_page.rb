module UserHomePage
  extend ActiveSupport::Concern

  private


  def redirect_to_role(user)
    case
    when user.type == 'Admin'
      redirect_to admin_root_url
    when user.type == 'Staff'
      redirect_to admin_school_url(user.school)
    when user.type == "Instructor"
      redirect_to admin_school_url(user.school)
    else
      raise "Unknown user type #{user.type}"
    end
  end
end