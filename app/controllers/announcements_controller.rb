class AnnouncementsController < ApplicationController 

	layout :resolve_layout
	def hide
		ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
		cookies.permanent.signed[:hidden_announcement_ids] = ids
		redirect_to :back
	end

	def index
		@announcements = Announcement.all
		status_vars
	end

	def new
		
		@announcement = Announcement.new
		@statusable = @announcement
		@statuses = Status.all
		
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

		@announcement = Announcement.find(params[:id])
		
		respond_to do |format|
			format.html { render @announcement }
			format.js
		end
	end

	def edit
		@announcement = Announcement.find(params[:id])
		status_vars
		respond_to do |format|
			format.html { render 'edit' }
			format.js
		end
	end

	def update
		@announcement = Announcement.find(params[:id])
		# @statusable = @announcement
		respond_to do |format|
			if @announcement.update_attributes(params[:announcement])
				format.html { redirect_to users_path, notice: "changes saved" }
				format.js
			end
		end
	end

	def destroy
		@announcement = Announcement.find(params[:id])
		@announcement.status_ids=[]
		@announcement.destroy
		respond_to do |format|
			format.html { redirect_to users_path }
			format.js
		end
	end

	def status_vars
		@statusable = @announcement
		@statuses = Status.all
	end
end
