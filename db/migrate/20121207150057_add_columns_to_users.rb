class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :integer
    add_column :users, :country, :string
    add_column :users, :cell, :string
    add_column :users, :phone, :string
    add_column :users, :school, :string
    add_column :users, :family, :string
    add_column :users, :user_type, :integer
  end
end
