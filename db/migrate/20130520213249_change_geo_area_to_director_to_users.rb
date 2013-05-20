class ChangeGeoAreaToDirectorToUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :geo_area, :regional_coor
  end

  def down
  	rename_column :users, :regional_coor, :geo_area
  end
end
