# == Schema Information
#
# Table name: applications
#
#  id                             :integer          not null, primary key
#  cover_letter                   :text
#  reviewed                       :boolean
#  opportunity_id                 :integer
#  student_id                     :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  resume                         :text
#  resume_file                    :string
#  application_state              :string           default("pending")
#  application_state_changed_by   :integer
#  application_state_changed_date :datetime
#

class Application < ActiveRecord::Base
  belongs_to :opportunity, counter_cache: true
  belongs_to :student
  belongs_to :application_state_changed_by, foreign_key: :application_state_changed_by, class_name: 'Staffer'
  has_many :application_events, -> { order('event_date DESC') }

  default_scope { order('created_at DESC') }

  before_validation :ensure_application_event, on: [:create]

  after_create :email_new_application, :pub_new_application
  after_update :email_updated_application, :pub_updated_application

  validates :application_state_changed_date, :application_state_changed_by, presence: true, unless: "application_state.eql? 'pending'"
  validates :application_state, inclusion: { in: %w[pending approved rejected] }
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
    self.where(application_state: 'pending')
  end

  def self.approved
    self.where(application_state: 'approved')
  end

  def self.rejected
    self.where(application_state: 'rejected')
  end

  def approve(staff)
    set_application_state(staff, 'approved')
  end

  def reject(staff)
    set_application_state(staff, 'rejected')
  end

  def set_application_state(staff, state)
    raise TypeError.new('Application state must be pending, approved, or rejected') unless %w[pending approved rejected].include? state
    self.application_state = state
    self.application_state_changed_by = staff
    self.application_state_changed_date = DateTime.now
  end

  def pending?
    application_state.eql? 'pending'
  end

  def approved?
    application_state.eql? 'approved'
  end

  def rejected?
    application_state.eql? 'rejected'
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
