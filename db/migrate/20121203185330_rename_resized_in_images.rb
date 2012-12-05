class RenameResizedInImages < ActiveRecord::Migration
  def up
  	rename_column :images, :resized, :day_dim
  	add_column :images, :week_dim, :string
  	add_column :images, :month_dim, :string
  	add_column :images, :year_dim, :string
  end

  def down
  	rename_column :images, :day_dim, :resized
  	remove_column :images, :week_dim, :string
  	remove_column :images, :month_dim, :string
  	remove_column :images, :year_dim, :string
  end
end
