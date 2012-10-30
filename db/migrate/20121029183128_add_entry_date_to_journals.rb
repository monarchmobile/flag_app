class AddEntryDateToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :entry_date, :datetime
  end
end
