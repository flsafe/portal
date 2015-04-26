class RenameApplicationsId < ActiveRecord::Migration
  def change
    if column_exists?(:application_events, :applications_id)
      rename_column :application_events, :applications_id, :application_id
    end
  end
end
