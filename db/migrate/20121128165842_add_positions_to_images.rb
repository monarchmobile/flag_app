class AddPositionsToImages < ActiveRecord::Migration
  def change
  	add_column :images, :day_p, :integer
  	add_column :images, :week_p, :integer
  	add_column :images, :month_p, :integer
  	add_column :images, :year_p, :integer
  end
end
