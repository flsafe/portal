class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :state
      t.boolean :is_open
      t.boolean :is_affilated

      t.timestamps null: false
    end
    add_reference :opportunities, :company, index: true
  end
end
