class DeleteColumnsFromStatuses < ActiveRecord::Migration
  def up
  	remove_column :statuses, :statusable_id
  	remove_column :statuses, :statusable_type
  end

  def down
  	add_column :statuses, :statusable_id, :integer
  	add_column :statuses, :statusable_type, :string
  end
end
