class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.text :cover_letter
      t.boolean :reviewed
      t.references :opportunity, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :applications, :opportunities
    add_foreign_key :applications, :users
  end
end
