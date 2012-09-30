class CreateArgumentVotes < ActiveRecord::Migration
  def change
    create_table :argument_votes do |t|
      t.references :user
      t.references :argument

      t.timestamps
    end
   
    add_index :argument_votes, :user_id
    add_index :argument_votes, :argument_id
  end
end
