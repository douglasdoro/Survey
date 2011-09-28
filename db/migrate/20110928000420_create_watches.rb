class CreateWatches < ActiveRecord::Migration
  def self.up
    create_table :watches do |t|
      t.references :user
      t.references :survey
      t.timestamps
    end
    
    add_index :watches, [:user_id, :survey_id]
  end

  def self.down
    drop_table :watches
  end
end
