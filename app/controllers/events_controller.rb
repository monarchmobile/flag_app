class EventsController < ApplicationController  

	layout :resolve_layout 

	def index
		@events = Event.all
		status_vars
	end

	def new
		@event = Event.new
		status_vars
	end

	def create
		@event = Event.new(params[:event])
		respond_to do |format|
			if @event.save
				format.html { redirect_to @event, :notice => "event has been save!" }
				format.js
			else
				format.html { redirect_to new_event_path, :notice => "You must fill out all required fields"}
				format.js
			end
		end
	end

	def show
		find_event
	end

	def edit
		find_event
		status_vars

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
		@event.status_ids=[]
		@event.destroy
		respond_to do |format|
			format.html {redirect_to dashboard_path}
			format.js
		end
	end

	def find_event
		@event = Event.find(params[:id])
	end

	def status_vars
		@statusable = @event
		@statuses = Status.all
	end



end