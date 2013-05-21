class CreateMessages < ActiveRecord::Migration
	def change
		create_table :messages do |t|
			t.text :content
			t.string :from_first_name
			t.string :from_last_name
			t.string :from_email
			t.string :from_phone_number
			t.references :user

			t.timestamps

		end
	end
end