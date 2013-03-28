class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :current_state
      t.belongs_to :statusable, polymorphic: true

      t.timestamps
    end
    add_index :statuses, [:statusable_id, :statusable_type]
  end
end
