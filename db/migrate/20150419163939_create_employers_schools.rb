class CreateEmployersSchools < ActiveRecord::Migration
  def change
    create_table :employers_schools do |t|
      t.integer :employer_id
      t.integer :school_id
    end
    add_index :employers_schools, :employer_id
    add_index :employers_schools, :school_id
  end
end
