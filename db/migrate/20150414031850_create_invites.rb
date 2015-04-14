class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :token
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :invites, :token
  end
end
