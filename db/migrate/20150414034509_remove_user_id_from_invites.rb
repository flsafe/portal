class RemoveUserIdFromInvites < ActiveRecord::Migration
  def change
    if column_exists?(:invites, :user_id)
      remove_column(:invites, :user_id)
    end
  end
end
