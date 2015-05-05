class AddDefaultsToApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :approved
    remove_column :applications, :approved_by
    remove_column :applications, :approved_date

    add_column :applications, :application_state, :string, default: 'pending'
    add_column :applications, :application_state_changed_by, :integer
    add_column :applications, :application_state_changed_date, :timestamp

    add_index :applications, :application_state
  end
end
