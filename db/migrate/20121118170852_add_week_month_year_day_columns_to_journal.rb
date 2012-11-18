class AddWeekMonthYearDayColumnsToJournal < ActiveRecord::Migration
  def change
  	add_column :journals, :day, :boolean
  	add_column :journals, :week, :boolean
  	add_column :journals, :month, :boolean
  	add_column :journals, :year, :boolean


  end
end
