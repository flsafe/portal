class AddSkillsToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :skills, :text
  end
end
