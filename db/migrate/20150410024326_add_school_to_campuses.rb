class AddSchoolToCampuses < ActiveRecord::Migration
  def change
    add_reference :campuses, :school, index: true
    add_foreign_key :campuses, :schools
  end
end
