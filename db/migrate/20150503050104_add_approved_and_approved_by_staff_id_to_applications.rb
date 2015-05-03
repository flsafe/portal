class AddApprovedAndApprovedByStaffIdToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :approved, :boolean
    add_column :applications, :approved_date, :timestamp
    add_column :applications, :approved_by, :integer
  end
end
