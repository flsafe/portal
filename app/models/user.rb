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
#

class User < ActiveRecord::Base
  belongs_to :school
  belongs_to :company
  has_many :applications
  has_secure_password

  validates :email, :avatar, :first_name, :last_name, :bio, :address1, :city, :state, :zip, presence: true
  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  ADMINS = %w[Admin]
  STAFFERS = %w[Staff Instructor]
  EMPLOYERS = %w[Employer]
  STUDENTS = %w[Student]

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
