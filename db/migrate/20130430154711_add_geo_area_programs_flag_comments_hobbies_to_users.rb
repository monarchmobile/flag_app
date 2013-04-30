class AddGeoAreaProgramsFlagCommentsHobbiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :geo_area, :integer
    add_column :users, :programs, :integer, :array => true
    add_column :users, :flag_comments, :text
    add_column :users, :hobbies, :text
  end
end
