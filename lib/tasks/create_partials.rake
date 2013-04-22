namespace :db do 
	desc "create partials"
	task :create_partials => :environment do
		Partial.create(name: "Announcement", position: 1)
		Partial.create(name: "Event", position: 2)
	end
end