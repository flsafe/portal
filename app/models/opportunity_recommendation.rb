# == Schema Information
#
# Table name: opportunity_recommendations
#
#  id                  :integer          not null, primary key
#  staffer_id          :integer
#  student_id          :integer
#  opportunity_id      :integer
#  recommendation_text :text
#  created_at          :datetime
#  updated_at          :datetime
#

class OpportunityRecommendation < ActiveRecord::Base
  default_scope { joins(:student).order('users.last_name ASC') }
  belongs_to :staffer
  belongs_to :opportunity
  belongs_to :student

  validates_uniqueness_of :student_id, scope: [:staffer, :opportunity]
end
