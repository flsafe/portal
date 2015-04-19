class AddApplicationProfileToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :screen_interview_date, :date
    add_column :applications, :screen_interview_notes, :text
    add_column :applications, :screen_interview_outcome, :text

    add_column :applications, :on_site_interview, :date
    add_column :applications, :on_site_notes, :text
    add_column :applications, :on_site_outcome, :text

    add_column :applications, :offer_date, :date
    add_column :applications, :offer_notes, :text
    add_column :applications, :offer_outcome, :text
  end
end
