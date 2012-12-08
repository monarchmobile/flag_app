class CreateScrapbooks < ActiveRecord::Migration
  def change
    create_table :scrapbooks do |t|
      t.string :period
      t.references :user

      t.timestamps
    end
  end
end



