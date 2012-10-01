class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.text :arg
      t.string :kind
      t.integer :count, :default => 0
      t.string :title
      t.integer :topic_user_id
      t.string :topic_user_email
      t.string :user_email
      t.references :topic
      t.references :user

      t.timestamps
    end
    add_index :arguments, :user_id
    add_index :arguments, :topic_id
  end
end
