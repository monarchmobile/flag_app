class RemovePublishedFromAnnouncements < ActiveRecord::Migration
  def up
  	remove_column :announcements, :published
  end

  def down
  	add_column :announcements, :published, :boolean, :default => false
  end
end
