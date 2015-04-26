class CreateApplicationEvents < ActiveRecord::Migration
  def change
    create_table :application_events do |t|
      t.string :title
      t.text :notes
      t.date :event_date

      t.timestamps null: false
    end
    add_reference :application_events, :application, index: true
  end
end
