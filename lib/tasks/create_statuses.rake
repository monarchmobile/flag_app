namespace :db do 
	desc "create status (draft, schedule, publish)" 
	task :create_statuses => :environment do 	
		Status.create(current_state: "draft")
		Status.create(current_state: "scheduled")
		Status.create(current_state: "published")
	end 
end