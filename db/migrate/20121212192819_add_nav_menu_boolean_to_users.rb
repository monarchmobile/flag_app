class AddNavMenuBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nav_menu, :integer
  end
end
