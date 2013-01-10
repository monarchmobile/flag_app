class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :owner_id
      t.date :beg_range
      t.integer :range_type
      t.references :user
      t.boolean :voted

      t.timestamps
    end
    add_index :votes, :user_id
  end
end
