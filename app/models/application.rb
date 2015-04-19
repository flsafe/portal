# == Schema Information
#
# Table name: applications
#
#  id                       :integer          not null, primary key
#  cover_letter             :text
#  reviewed                 :boolean
#  opportunity_id           :integer
#  user_id                  :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  resume                   :text
#  resume_file              :string
#  screen_interview_date    :date
#  screen_interview_notes   :text
#  screen_interview_outcome :text
#  on_site_interview        :date
#  on_site_notes            :text
#  on_site_outcome          :text
#  offer_date               :date
#  offer_notes              :text
#  offer_outcome            :text
#

class Application < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :student

  validates :cover_letter, presence: true
  validates :cover_letter, uniqueness: true
  validates :resume, presence: true, if: 'resume_file.blank?'
  validates :resume_file, presence: true, if: 'resume.blank?'
  validates_uniqueness_of :user_id, scope: [:opportunity_id], message: "The user has already applied to that opportunity."

  mount_uploader :resume_file, ResumeFileUploader
end
