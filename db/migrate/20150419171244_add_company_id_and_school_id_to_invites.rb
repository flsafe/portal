class AddCompanyIdAndSchoolIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :company_id, :integer
    add_column :invites, :school_id, :integer
  end
end
