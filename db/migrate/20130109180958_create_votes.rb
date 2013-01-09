class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.integer :owner_id
      t.date :votable_range

      t.timestamps
    end
    add_index :votes, :user_id
  end
end
