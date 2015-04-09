class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campuses do |t|
      t.string :name
      t.string :phone
      t.string :custom_domain
      t.string :website
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps null: false
    end
  end
end
