class AddNavMenuToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nav_menu, :boolean
  end
end
