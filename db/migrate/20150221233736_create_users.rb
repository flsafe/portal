class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :password_digest
      t.integer :role, default: 1

      t.timestamps null: false
    end
  end
end
