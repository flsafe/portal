class AddApplicationsCountToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :applications_count, :integer
  end
end
