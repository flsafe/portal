# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  website     :string
#  address1    :string
#  address2    :string
#  city        :string
#  state       :string
#  zip         :string
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class Company < ActiveRecord::Base
  has_many :opportunities
end
