class CreatePartnerships < ActiveRecord::Migration
  def change
    drop_table :schools_users
    create_table :partnerships do |t|
      t.integer :employer_id
      t.integer :school_id
      t.timestamps
    end
  end
end
