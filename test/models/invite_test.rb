# == Schema Information
#
# Table name: invites
#
#  id          :integer          not null, primary key
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  invite_type :string
#  email       :string
#  semester    :string
#  year        :integer
#  campus_id   :integer
#

require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
