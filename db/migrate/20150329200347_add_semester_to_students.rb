class AddSemesterToStudents < ActiveRecord::Migration
  def change
    add_column :students, :semester, :integer
  end
end
