class AnnouncementsController < ApplicationController 

	layout :resolve_layout
	before_filter :authorize
	def index
		reset_current_state(Announcement)
		all_announcement_states
		@announcements = Announcement.published
	end

	def new
		@announcement = Announcement.new
		@recipients = Role.all
		@announcement.send_list = []
	end

	def create
		@announcement = Announcement.new(params[:announcement])
		@announcement.starts_at = params[:announcement][:starts_at].blank? ? Date.today : params[:announcement][:starts_at] 
		respond_to do |format|
			if @announcement.save
				# published = Status.find_by_status_name("published").id
				@announcement.send_announcement_email if @announcement.is_published?
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

	def announcement_partial
		reset_current_state(Announcement)
    @announcements_partial = Describe.new(Announcement).partial.published
    @model_name = "Announcement"
    render 'shared/quick_partial_view', model_name: @model_name
  end

	def edit
		@recipients = Role.all
		find_announcement
		respond_to do |format|
			format.html { render 'edit' }
			format.js
		end
	end

	def update
		all_announcement_states
		find_announcement
		@announcement.send_list = params[:announcement][:send_list_array]
		position = params[:announcement][:position]
		current_state = params[:announcement][:current_state]
		published = Status.find_by_status_name("published").id
		if (!current_state ==  published) 
			@announcement.position = nil
		end
		respond_to do |format|
			if @announcement.update_attributes(params[:announcement])
				format.html { redirect_to announcements_path, notice: "changes saved" }
				format.js
			end
		end
	end

	def destroy
		find_announcement
		@announcement.destroy
		respond_to do |format|
			format.html { redirect_to dashboard_path }
			format.js
		end
	end

		def announcement_status
		all_announcement_states
		find_announcement
		current_state = params[:announcement][:current_state]
		total_published = Announcement.published.count
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			@announcement.update_attributes({current_state: current_state, position: total_published})
		else
			@announcement.update_attributes({current_state: current_state, position: nil})
		end
		Announcement.published.each_with_index do |id, index|
	    Announcement.published.update_all({position: index+1}, {id: id})
	  end
		render "update.js"

	end

	def announcement_starts_at
		
		find_announcement
		starts_at = params[:announcement][:starts_at]
		current_state = params[:announcement][:current_state]
		total_published = Announcement.published.count

		@announcement.update_attributes({starts_at: starts_at})
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			Announcement.published.each_with_index do |id, index|
		    Announcement.published.update_all({position: index+1}, {id: id})
		  end
		end
		
	  allAnnouncementStates
		render "update.js"
	end

	def announcement_ends_at
		
		find_announcement
		ends_at = params[:announcement][:ends_at]
		current_state = params[:announcement][:current_state]
		total_published = Announcement.published.count
		
		@announcement.update_attributes({ends_at: ends_at})
		published = Status.find_by_status_name("published").id
		if (current_state ==  published) 
			Announcement.published.each_with_index do |id, index|
		    Announcement.published.update_all({position: index+1}, {id: id})
		  end
		end
	  allAnnouncementStates
		render "update.js"
		
	end

	def find_announcement
		@announcement = Announcement.find(params[:id])
	end

	def sort
		all_announcement_states
		params[:announcement].each_with_index do |id, index|
	    Announcement.update_all({position: index+1}, {id: id})
	  end
		render "update.js"
	end

	def all_announcement_states
		@published_announcements = Announcement.published.order_by_position
		@scheduled_announcements = Announcement.scheduled.order_by_position
		@draft_announcements = Announcement.draft.order_by_position

	end

	def hide
		ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
		cookies.permanent.signed[:hidden_announcement_ids] = ids
		redirect_to :back
	end
end
