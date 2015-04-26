class AddDescriptionToApplicationEvents < ActiveRecord::Migration
  def change
    add_column :application_events, :description, :text
  end
end
