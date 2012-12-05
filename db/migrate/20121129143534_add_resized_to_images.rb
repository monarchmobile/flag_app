class AddResizedToImages < ActiveRecord::Migration
  def change
  	add_column :images, :resized, :string
  end
end
