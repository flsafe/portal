class OpportunityRecommendation < ActiveRecord::Base
  default_scope { joins(:student).order('users.last_name ASC') }
  belongs_to :staffer
  belongs_to :opportunity
  belongs_to :student

  validates_uniqueness_of :student_id, scope: [:staffer, :opportunity]
end