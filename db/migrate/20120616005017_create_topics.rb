class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :title
      t.integer :count, :default => 0
      t.string :user_email
      t.references :user

      t.timestamps
    end
    add_index :topics, :user_id
  end
end
