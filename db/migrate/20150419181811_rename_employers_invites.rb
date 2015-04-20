class RenameEmployersInvites < ActiveRecord::Migration
  def change
    rename_table :employers_schools, :schools_users
  end
end
