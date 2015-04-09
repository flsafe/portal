class AddCampusToSchool < ActiveRecord::Migration
  def change
    add_reference :schools, :campus, index: true
    add_foreign_key :schools, :campuses
  end
end
