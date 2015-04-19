class RenameApplicationsUserId < ActiveRecord::Migration
  def change
    rename_column :applications, :user_id, :student_id
  end
end
