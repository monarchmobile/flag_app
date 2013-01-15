class AddZToImages < ActiveRecord::Migration
  def change
    add_column :images, :day_z, :integer
    add_column :images, :week_z, :integer
    add_column :images, :month_z, :integer
    add_column :images, :year_z, :integer
  end
end
