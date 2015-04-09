class AddCampusRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :campus, index: true
    add_foreign_key :users, :campuses
  end
end
