class DropApplicatonEventsFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :screen_interview_date
    remove_column :applications, :screen_interview_notes
    remove_column :applications, :screen_interview_outcome
    remove_column :applications, :on_site_interview
    remove_column :applications, :on_site_notes
    remove_column :applications, :on_site_outcome
    remove_column :applications, :offer_date
    remove_column :applications, :offer_notes
    remove_column :applications, :offer_outcome
  end
end
