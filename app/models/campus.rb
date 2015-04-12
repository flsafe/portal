# == Schema Information
#
# Table name: campuses
#
#  id            :integer          not null, primary key
#  name          :string
#  phone         :string
#  custom_domain :string
#  website       :string
#  address1      :string
#  address2      :string
#  city          :string
#  state         :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  school_id     :integer
#

class Campus < ActiveRecord::Base
  belongs_to :school
  has_many :students
  has_many :employers

  validates :name, :school_id, presence: true
  validates :name, uniqueness: true
end
