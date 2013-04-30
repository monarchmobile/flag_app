class Program < ActiveRecord::Base
	attr_accessible :name, :body

	has_many :user_programs
	has_many :users, :through => :user_programs
	
end