class AddApplicationRecommendations < ActiveRecord::Migration
  def change
    create_table :application_recommendations do |t|
      t.text :recommendation_text
      t.timestamps
    end
    add_reference :application_recommendations, :staffer, index: true
    add_reference :application_recommendations, :application, index: true
    add_index :application_recommendations, [:staffer_id, :application_id], unique: true, name: 'app_recs_uniq_staffer_id_application_id'
  end
end
