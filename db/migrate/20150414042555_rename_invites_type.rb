class RenameInvitesType < ActiveRecord::Migration
  def change
    rename_column :invites, :type, :invite_type
  end
end
