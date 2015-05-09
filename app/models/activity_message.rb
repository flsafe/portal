# == Schema Information
#
# Table name: activity_messages
#
#  id             :integer          not null, primary key
#  type           :string
#  school_id      :integer
#  application_id :integer
#  student_id     :integer
#  employer_id    :integer
#  staff_id       :integer
#  opportunity_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ActivityMessage < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  belongs_to :application
  belongs_to :application_event
  belongs_to :staffer
  belongs_to :school 

  validates :school, presence: true
end
