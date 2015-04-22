# == Schema Information
#
# Table name: schools
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
#  campus_id     :integer
#

class School < ActiveRecord::Base
  has_many :campuses
  has_many :users
  has_many :students
  has_many :staff
  has_many :partnerships
  has_many :employers, through: :partnerships
end
