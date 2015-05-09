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

require 'test_helper'

class ApplicationEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
