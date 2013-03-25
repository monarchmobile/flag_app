namespace :db do 
	desc "create roles" 
	task :create_roles => :environment do 	
		Role.create(name: "SuperAdmin")
		Role.create(name: "Admin")
		Role.create(name: "Staff")
		Role.create(name: "Student")
		Role.create(name: "Coordinator")
		Role.create(name: "Moderator")
		Role.create(name: "Host-Family")
		Role.create(name: "Guest")
	end 
end