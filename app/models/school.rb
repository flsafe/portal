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
#

class School < ActiveRecord::Base
  has_many :users
end
