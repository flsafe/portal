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

require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
