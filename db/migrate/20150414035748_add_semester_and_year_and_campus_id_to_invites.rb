class AddSemesterAndYearAndCampusIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :semster, :string
    add_column :invites, :year, :integer
    add_column :invites, :campus_id, :integer
  end
end
