class CreateOpportunityRecommendations < ActiveRecord::Migration
  def change
    create_table :opportunity_recommendations do |t|
      t.integer :staffer_id
      t.integer :student_id
      t.integer :opportunity_id
      t.text :recommendation_text
      t.timestamps
    end

    add_index :opportunity_recommendations, :staffer_id
    add_index :opportunity_recommendations, :student_id
    add_index :opportunity_recommendations, :opportunity_id
    add_index :opportunity_recommendations, [:staffer_id, :student_id, :opportunity_id], unique: true, name: :unique_staffer_student_opportunity
  end
end
