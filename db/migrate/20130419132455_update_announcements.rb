class UpdateAnnouncements < ActiveRecord::Migration
  def up
  	add_column :announcements, :current_state, :integer
  	add_column :announcements, :position, :integer
  end

  def down
  	remove_column :announcements, :current_state
  	remove_column :announcements, :position
  end
end
