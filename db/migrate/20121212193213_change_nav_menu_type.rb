class ChangeNavMenuType < ActiveRecord::Migration
  remove_column :users, :nav_menu
end
