# == Schema Information
#
# Table name: invites
#
#  id          :integer          not null, primary key
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  invite_type :string
#  email       :string
#  semester    :string
#  year        :integer
#  campus_id   :integer
#  company_id  :integer
#  school_id   :integer
#

# TODO The invite shouldn't be valid if the user already exist and doesn't match the invite type.
class Invite < ActiveRecord::Base
  belongs_to :campus

  validates :token, :invite_type, :email, presence: true 
  validates :token, :email, uniqueness: true
  validates :semester, :year, :campus_id, presence: true, if: "invite_type == 'Student'"
  validates :school_id, :company_id, presence: true, if: "invite_type == 'Employer'"
  validate :user_must_not_exist

  before_validation :create_token

  def create_token
    self.token = self.token || SecureRandom.hex
  end

  def user_must_not_exist
    errors.add(:base, "The person #{email} already exists") if User.exists?(email: email)
  end
end
