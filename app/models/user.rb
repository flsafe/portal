class User < ActiveRecord::Base
  belongs_to :school
  belongs_to :company
  has_secure_password

  ADMINS = %w[Admin]
  STAFFERS = %w[Staff Instructor]
  EMPLOYERS = %w[Employer]

  def admin?
    ADMINS.include?(type)
  end

  def staff? 
    STAFFERS.include?(type)
  end

  def admin_or_staff?
    (ADMINS + STAFFERS).include?(type)
  end

  def employer?
    EMPLOYERS.include?(type)
  end
end
