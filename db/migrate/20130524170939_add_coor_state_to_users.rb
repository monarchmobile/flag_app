class AddCoorStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coor_state, :string
  end
end
