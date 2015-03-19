# == Schema Information
#
# Table name: applications
#
#  id             :integer          not null, primary key
#  cover_letter   :text
#  reviewed       :boolean
#  opportunity_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  resume         :text
#

class Application < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user

  validates :cover_letter, presence: true
  validates :cover_letter, uniqueness: true
  validates_uniqueness_of :user_id, scope: [:opportunity_id], message: "The user has already applied to that opportunity."
end
