class ChangeUserTypeInScrapbooks < ActiveRecord::Migration
  def up
  	change_column :scrapbooks, :user_id, :integer
  end

  def down
  end
end
