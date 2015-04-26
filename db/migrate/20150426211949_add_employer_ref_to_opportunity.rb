class AddEmployerRefToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :employer_id, :integer, index: true
  end
end
