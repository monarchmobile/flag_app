class AddStartsAtAndEndsAtToPages < ActiveRecord::Migration
  def up
  	add_column :pages, :starts_at, :date
  	add_column :pages, :ends_at, :date
  end

  def down
  	removes_column :pages, :starts_at
  	removes_column :pages, :ends_at
  end
end
