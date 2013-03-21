class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.string :location
      t.text :description
      t.date :publish_to_web
      t.date :pull_from_web

      t.timestamps
    end
  end
end
