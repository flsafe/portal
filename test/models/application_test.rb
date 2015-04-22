# == Schema Information
#
# Table name: applications
#
#  id                       :integer          not null, primary key
#  cover_letter             :text
#  reviewed                 :boolean
#  opportunity_id           :integer
#  student_id               :integer
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

require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
