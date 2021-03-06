# == Schema Information
#
# Table name: application_events
#
#  id             :integer          not null, primary key
#  title          :string
#  notes          :text
#  event_date     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  application_id :integer
#  description    :text
#  staffer_id     :integer
#

class ApplicationEvent < ActiveRecord::Base
  APP_EVENTS = %w[
    application_rejected
    application_no_response
    screen_interview
    screen_interview_rejected
    on_site_interview
    no_offer
    accepted_offer
    rejected_offer
  ]

  belongs_to :application
  belongs_to :staffer

  validates :title, :application, presence: true
  validates :staffer, presence: true
  validates :title, inclusion: {in: APP_EVENTS}
end
