class AnnouncementsController < ApplicationController 

	layout :resolve_layout
	def hide
		ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
		cookies.permanent.signed[:hidden_announcement_ids] = ids
		redirect_to :back
	end

	def index
		@announcements = Announcement.all
		render { 'index' }
	end

	def new
		@announcement = Announcement.new
	end

	def create
		@announcement = Announcement.new(params[:announcement])

		
		if @announcement.save
			redirect_to users_path
			
		else
			redirect_to 'new'
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
		@statusable = @announcement
		@statuses = Status.all
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
end
