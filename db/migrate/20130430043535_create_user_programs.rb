class CreateUserPrograms < ActiveRecord::Migration
	def change 
		create_table :user_programs, :id => false do |t|
			t.references :user 
			t.references :program
		end
	end
end
