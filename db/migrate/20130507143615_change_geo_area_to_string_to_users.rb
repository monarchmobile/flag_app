class ChangeGeoAreaToStringToUsers < ActiveRecord::Migration
  def up
  	change_column :users, :geo_area, :string
  end

  def down
  	change_column :users, :geo_area, :integer
  end
end
