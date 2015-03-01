class AddResumeToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :resume, :text
  end
end
