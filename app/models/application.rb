class Application < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:opportunity_id], message: "The user has already applied to that opportunity."
end
