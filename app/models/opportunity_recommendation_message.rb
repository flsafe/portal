# == Schema Information
#
# Table name: activity_messages
#
#  id                   :integer          not null, primary key
#  type                 :string
#  school_id            :integer
#  application_id       :integer
#  student_id           :integer
#  employer_id          :integer
#  staff_id             :integer
#  opportunity_id       :integer
#  created_at           :datetime
#  updated_at           :datetime
#  application_event_id :integer
#  staffer_id           :integer
#

class OpportunityRecommendationMessage < ActivityMessage
  validates :staffer, :opportunity, :student, presence: true
end
