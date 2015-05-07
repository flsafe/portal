class ActivityMessage < ActiveRecord::Migration
  def change
    create_table :activity_messages do |t|
      t.string :type
      t.references :school
      t.references :application
      t.references :student
      t.references :employer
      t.references :staff
      t.references :opportunity
      t.timestamps
    end
  end
end
