class CreatePrograms < ActiveRecord::Migration
	def change
		create_table :programs do |t|
			t.string :name
			t.text :body

			t.timestamps
		end
	end
end