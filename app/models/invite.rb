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
#

class Invite < ActiveRecord::Base
  validates :token, :invite_type, :email, presence: true 
  validates :token, :email, uniqueness: true
  validates :semster, :year, :campus_id, presence: true, if: "invite_type == 'Student'"

  before_validation :create_token

  def create_token
    self.token = SecureRandom.hex
  end
end
