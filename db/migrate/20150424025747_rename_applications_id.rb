class RenameApplicationsId < ActiveRecord::Migration
  def change
    rename_column :application_events, :applications_id, :application_id
  end
end
