# == Schema Information
#
# Table name: applications
#
#  id             :integer          not null, primary key
#  cover_letter   :text
#  reviewed       :boolean
#  opportunity_id :integer
#  student_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  resume         :text
#  resume_file    :string
#

class Application < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :student
  has_many :application_events, -> { order('event_date DESC') }

  before_validation :ensure_application_event, on: [:create]

  validates :cover_letter, presence: true
  validates :cover_letter, uniqueness: true
  validates :resume, presence: true, if: 'resume_file.blank?'
  validates :resume_file, presence: true, if: 'resume.blank?'
  validates :application_events, presence: true  # At least the initial application event
  validates_uniqueness_of :student_id, scope: [:opportunity_id], message: "The user has already applied to that opportunity."

  mount_uploader :resume_file, ResumeFileUploader

  def ensure_application_event
    application_events.build(title: ApplicationEvent::INITIAL_APP_EVENT) if application_events.count == 0
  end
end
