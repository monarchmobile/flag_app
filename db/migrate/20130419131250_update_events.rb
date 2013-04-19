class UpdateEvents < ActiveRecord::Migration
  def up
  	remove_column :events, :date
  	remove_column :events, :description
  	remove_column :events, :publish_to_web
  	remove_column :events, :pull_from_web

  	add_column :events, :slug, :string
  	add_column :events, :body, :text
  	add_column :events, :event_start, :date
  	add_column :events, :event_end, :date
  	add_column :events, :featured, :boolean

  	add_column :events, :starts_at, :date
  	add_column :events, :ends_at, :date
  	add_column :events, :current_state, :integer
  	add_column :events, :position, :integer

  end

  def down
  end
end
