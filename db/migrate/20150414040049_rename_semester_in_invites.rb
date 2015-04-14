class RenameSemesterInInvites < ActiveRecord::Migration
  def change
    rename_column :invites, :semster, :semester
  end
end
