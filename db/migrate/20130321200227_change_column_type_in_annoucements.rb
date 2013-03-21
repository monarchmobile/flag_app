class ChangeColumnTypeInAnnoucements < ActiveRecord::Migration
  def up
  	remove_column :announcements, :starts_at
  	remove_column :announcements, :ends_at
  	add_column :announcements, :starts_at, :date
  	add_column :announcements, :ends_at, :date
  end

  
end
