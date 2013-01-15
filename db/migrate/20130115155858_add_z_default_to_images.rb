class AddZDefaultToImages < ActiveRecord::Migration
  def change
  	change_column :images, :day_z, :integer, :default => 500
    change_column :images, :week_z, :integer, :default => 500
    change_column :images, :month_z, :integer, :default => 500
    change_column :images, :year_z, :integer, :default => 500
  end
end
