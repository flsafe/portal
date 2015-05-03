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
#  approved       :boolean
#  approved_date  :datetime
#  approved_by    :integer
#

class Application < ActiveRecord::Base
  belongs_to :opportunity, counter_cache: true
  belongs_to :student
  belongs_to :approved_by, foreign_key: :approved_by, class_name: 'Staff'
  has_many :application_events, -> { order('event_date DESC') }

  default_scope { order('created_at DESC') }

  before_validation :ensure_application_event, on: [:create]

  after_create :email_new_application, :pub_new_application
  after_update :email_updated_application, :pub_updated_application

  validates :approved_date, :approved_by, presence: true, if: 'approved?'
  validates :cover_letter, presence: true
  validates :cover_letter, uniqueness: true
  validates :resume, presence: true, if: 'resume_file.blank?'
  validates :resume_file, presence: true, if: 'resume.blank?'
  validates :application_events, presence: true  # At least the initial application event
  validates_uniqueness_of :student_id, scope: [:opportunity_id], message: "The user has already applied to that opportunity."

  mount_uploader :resume_file, ResumeFileUploader

  def self.through_partners(school)
    self.where(opportunity: Opportunity.partnered(school))
  end

  def self.pending
    self.where(approved: nil)
  end

  def self.approved
    self.where(approved: true)
  end

  def self.rejected
    self.where(approved: false)
  end

  def approve(staff)
    self.approved = true
    self.approved_date = DateTime.now
    self.approved_by = staff
  end

  def email_new_application
    # email staff
  end

  def email_updated_application
    # email employer if the application has been approved
  end

  def pub_new_application
    # publish new application event
  end

  def pub_updated_application
    # publish approved application event if
    # this application has been approved
  end

  def ensure_application_event
    application_events.build(application: self,
                             title: ApplicationEvent::INITIAL_APP_EVENT,
                             event_date: Date.today) if application_events.count == 0
  end
end
