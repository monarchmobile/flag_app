class EventsController < ApplicationController 

	layout :resolve_layout
	def new
		@event = Event.new
	end

	def show
		find_event
	end

	def index
		@events = Event.all
	end

	def create
		@event = Event.new(params[:event])
		respond_to do |format|
			if @event.save
				format.html { redirect_to @event, :notice => "event has been save!" }
				format.js
			else
				format.html { render 'new', notice: "event did not save"}
				format.js
			end
		end
	end

	def edit
		find_event

	end

	def update
		find_event
		respond_to do |format|
			if @event.update_attributes(params[:event])
				format.html { redirect_to @event, notice: "changes saved" }
				format.js
			else
				format.html { render 'edit', :notice => "updates not saved"}
				format.js
			end
		end
	end

	def destroy
		find_event
		@event.destroy
		respond_to do |format|
			format.html {redirect_to dashboard_path, "#{@event.title} deleted succesfully"}
			format.js
		end
	end

	def find_event
		@event = Event.find(params[:id])
	end



end