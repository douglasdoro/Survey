class AddPublishedToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :published, :boolean
  end

  def self.down
    remove_column :surveys, :published
  end
end
