class PagesController < ApplicationController 
	
	before_filter :load_page, :only => [:show, :edit, :update, :destroy, :status ]
	before_filter :all_page_states, :only => [:index, :update, :sort, :status ]
	layout :resolve_layout
	authorize_resource
	def new 
		all_page_states
		@page = Page.new
		@links = Link.all
	end

	def index
		# publish_page_if_in_range
		@links = Link.all
	end

	def show 
		reset_current_state(Announcement)
		reset_current_state(Event)
		publish_page_if_in_range
		announcement_mailer # sends announcement mailer if start_at is today
		all_page_states
		@announcements_partial = Announcement.limit(5).order("starts_at DESC").published
		@events_partial = Event.limit(5).order("starts_at DESC").published
		@images_partial = Image.order("RANDOM()").limit(10).last
	end

	def edit 
		@links = Link.all
		all_page_states
	end

	def create 
		@page = Page.new(params[:page])
		respond_to do |format|
			if @page.save
				format.html { redirect_to @page, :notice => "The #{@page.title} page was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "page could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		position = params[:page][:position]
		current_state = params[:page][:current_state]
		@link_ids = params[:page][:link_ids]
		published = Status.find_by_status_name("published").id
		@page.check_start_date
		respond_to do |format|
			if @page.update_attributes(params[:page])
				# reorder_pages(@page)
				format.html { redirect_to @page, :notice => "The #{@page.title} page was succesfully updated"}
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		@page.link_ids=[]
		@page.destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js
		end
	end

	def load_page 
		@page = Page.find(params[:id])
	end

	def sort
	  params[:page].each_with_index do |id, index|
	    Page.update_all({position: index+1}, {id: id})
	  end
	  render "update.js"
	end

	def status
		load_page
		current_state = params[:page][:current_state]
		total_published = Describe.new(Page).published.count
		published = Status.find_by_status_name("published").id
		scheduled = Status.find_by_status_name("scheduled").id
		draft = Status.find_by_status_name("draft").id
		if (current_state.to_i == published)
			if @page.starts_at.blank?
				@page.update_attributes({current_state: current_state, starts_at: Date.today})
			else
				@page.update_attributes({current_state: current_state})
			end
		elsif (current_state.to_i == scheduled)
			@page.update_attributes({current_state: current_state, position: nil, starts_at: nil })
		elsif (current_state.to_i == draft)
			@page.update_attributes({current_state: current_state, position: nil, starts_at: nil })
		end
		Page.published.each_with_index do |id, index|
	    Page.published.update_all({position: index+1}, {id: id})
	  end
		all_page_states
		render "update.js"
			
	end

	def link
	  load_page
	  if @page.update_attributes(params[:page])
	  	all_page_states
	  	render "update.js"
	  end
	end

	def all_page_states
		@published_pages = Page.published.order_by_position
		@scheduled_pages = Page.scheduled.order_by_position
		@draft_pages = Page.draft.order_by_position
		@links = Link.all
		@partials = Partial.all
	end

end
