class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :title
      t.integer :count, :default => 0
      t.references :user
      t.string :user_email

      t.timestamps
    end
    add_index :topics, :user_id
  end
end
