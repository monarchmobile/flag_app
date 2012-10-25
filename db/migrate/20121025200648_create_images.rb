class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.text :content
      t.datetime :date_taken
      t.boolean :week
      t.boolean :month
      t.boolean :year

      t.timestamps
    end
  end
end
