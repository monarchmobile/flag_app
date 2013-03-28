class AnnouncementsController < ApplicationController 

	layout :resolve_layout
	
	def index
		@announcements = Announcement.all
		status_vars
	end

	def new
		@announcement = Announcement.new
		status_vars
	end

	def create
		@announcement = Announcement.new(params[:announcement])
		respond_to do |format|
			if @announcement.save
				format.html { redirect_to dashboard_path }
				format.js
			else
				format.html { redirect_to new_announcement_path, :notice => "You must fill out all required fields"}
				format.js
			end
		end
	end
	
	def show
		find_announcement
		respond_to do |format|
			format.html { render @announcement }
			format.js
		end
	end

	def edit
		find_announcement
		status_vars
		respond_to do |format|
			format.html { render 'edit' }
			format.js
		end
	end

	def update
		find_announcement
		# @statusable = @announcement
		respond_to do |format|
			if @announcement.update_attributes(params[:announcement])
				format.html { redirect_to users_path, notice: "changes saved" }
				format.js
			end
		end
	end

	def destroy
		find_announcement
		@announcement.status_ids=[]
		@announcement.destroy
		respond_to do |format|
			format.html { redirect_to dashboard_path }
			format.js
		end
	end

	def find_announcement
		@announcement = Announcement.find(params[:id])
	end

	def status_vars
		@statusable = @announcement
		@statuses = Status.all
	end

	def hide
		ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
		cookies.permanent.signed[:hidden_announcement_ids] = ids
		redirect_to :back
	end
end
