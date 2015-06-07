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
    .includes(:student)
  }

  belongs_to :application
  belongs_to :application_event
  belongs_to :employer
  belongs_to :student
  belongs_to :staffer
  belongs_to :opportunity
  belongs_to :school 

  has_many :message_confirmation

  validates :school, presence: true

  def self.employer_feed(partner_school_ids)
    ActivityMessage.joins(:application)
                   .joins('LEFT OUTER JOIN message_confirmations ON message_confirmations.activity_message_id = activity_messages.id')
                   .where(school_id: partner_school_ids,
                          'applications.application_state' => 'approved',
                          type: %w[ApplicationMessage
                                   ApplicationRecommendationMessage
                                   OpportunityRecommendationMessage])
                    .where('message_confirmations.created_at IS NULL')
  end
end
