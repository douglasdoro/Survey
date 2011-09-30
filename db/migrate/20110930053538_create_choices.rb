class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :choices
  end
end
