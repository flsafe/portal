class AddResumeFileToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :resume_file, :string
  end
end
