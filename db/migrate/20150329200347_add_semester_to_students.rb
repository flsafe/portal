class AddSemesterToStudents < ActiveRecord::Migration
  def change
    add_column :users, :semester, :integer
  end
end
