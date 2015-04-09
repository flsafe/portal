# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  bio             :text
#  address1        :string
#  address2        :string
#  city            :string
#  state           :string
#  zip             :string
#  password_digest :string
#  role            :integer          default(1)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  school_id       :integer
#  company_id      :integer
#  type            :string
#  avatar          :string
#  phone           :string
#  github_token    :string
#  semester        :integer
#  year            :integer
#  campus_id       :integer
#

class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  ADMINS = %w[Admin]
  STAFFERS = %w[Staff Instructor]
  EMPLOYERS = %w[Employer]
  STUDENTS = %w[Student]

  def name
    "#{first_name} #{last_name}"
  end

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

  def student?
    STUDENTS.include?(type)
  end
end
