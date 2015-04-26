# == Schema Information
#
# Table name: opportunities
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  city         :string
#  state        :string
#  is_open      :boolean
#  is_affilated :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  skills       :text
#  requirements :text
#  employer_id  :integer
#

require 'test_helper'

class OpportunityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
