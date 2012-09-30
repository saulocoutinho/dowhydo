class CreateTopicVotes < ActiveRecord::Migration
  def change
    create_table :topic_votes do |t|
      t.integer :kind
      t.references :user
      t.references :topic

      t.timestamps
    end
    add_index :topic_votes, :user_id
    add_index :topic_votes, :topic_id
  end
end
