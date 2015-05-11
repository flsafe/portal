# == Schema Information
#
# Table name: application_recommendations
#
#  id                  :integer          not null, primary key
#  recommendation_text :text
#  created_at          :datetime
#  updated_at          :datetime
#  staffer_id          :integer
#  application_id      :integer
#

class ApplicationRecommendation < ActiveRecord::Base
  belongs_to :staffer
  belongs_to :application

  validates_uniqueness_of :application_id, scope: :staffer_id
end
