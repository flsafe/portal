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
#  grad_year       :integer
#

class Staffer < User
  belongs_to :school
  has_many :application_recommendations
  has_many :opportunity_recommendations

  validates :first_name, :last_name, :city, :state, presence: true
end
