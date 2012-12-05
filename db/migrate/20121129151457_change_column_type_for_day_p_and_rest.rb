class ChangeColumnTypeForDayPAndRest < ActiveRecord::Migration
  def up
  	change_column :images, :day_p, :string
  	change_column :images, :week_p, :string
  	change_column :images, :month_p, :string
  	change_column :images, :year_p, :string

  end

  def down
  end
end
