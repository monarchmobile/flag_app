class AddColumnsToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :send_at, :date
    add_column :announcements, :send_list, :string
    add_column :announcements, :sent, :boolean, :default => false
  end
end
