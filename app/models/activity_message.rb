# == Schema Information
#
# Table name: activity_messages
#
#  id                   :integer          not null, primary key
#  type                 :string
#  school_id            :integer
#  application_id       :integer
#  student_id           :integer
#  employer_id          :integer
#  staff_id             :integer
#  opportunity_id       :integer
#  created_at           :datetime
#  updated_at           :datetime
#  application_event_id :integer
#  staffer_id           :integer
#

class ActivityMessage < ActiveRecord::Base
  default_scope { 
    order('created_at DESC')
    .includes(application: {opportunity: :company})
    .includes(application: :student)
    .includes(application: :application_state_changed_by)
    .includes(:application_event, :staffer, :employer)
    .includes(opportunity: :company)
  }

  belongs_to :application
  belongs_to :application_event
  belongs_to :employer
  belongs_to :staffer
  belongs_to :opportunity
  belongs_to :school 

  validates :school, presence: true
end
