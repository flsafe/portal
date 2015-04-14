class AddUniqueIndexToInvites < ActiveRecord::Migration
  def change
    remove_index :invites, :token if index_exists?(:invites, :token)
    add_index :invites, :token, unique: true
  end
end
