class AddPublishedToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :published, :boolean, :default => false
  end
end
