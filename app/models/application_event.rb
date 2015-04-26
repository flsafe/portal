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
#

class ApplicationEvent < ActiveRecord::Base
  INITIAL_APP_EVENT = 'applied'

  APP_EVENTS = %w[
    applied
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

  validates :title, :application, presence: true
end