class AddEmailToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :email, :string
    add_index :invites, :email, unique: true
  end
end
