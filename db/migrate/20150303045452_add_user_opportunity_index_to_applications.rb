class AddUserOpportunityIndexToApplications < ActiveRecord::Migration
  def change
    add_index(:applications, [:user_id, :opportunity_id], unique: true)
  end
end
