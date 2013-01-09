class AddRangeTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :range_type, :integer
  end
end
