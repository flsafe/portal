# == Schema Information
#
# Table name: partnerships
#
#  id          :integer          not null, primary key
#  employer_id :integer
#  school_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Partnership < ActiveRecord::Base
  belongs_to :school
  belongs_to :employer
end
