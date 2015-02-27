module UserHomePage
  extend ActiveSupport::Concern

  private

  def redirect_to_role(user)
    case
    when user.type == 'Admin'
      redirect_to admin_root_url
    when %w[Staff Instructor].include?(user.type)
      redirect_to admin_school_url(user.school)
    else
      raise "Unknown user type #{user.type}"
    end
  end
end