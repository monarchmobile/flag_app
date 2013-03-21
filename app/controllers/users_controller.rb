class UsersController < ApplicationController 
	respond_to :html, :json 
	include ApplicationHelper 
 
	def index 
		@announcements = Announcement.all
		@events = Event.all

	end
	
	def new 
		
		@user = User.new
	end
	
	def show
		@user = User.find(params[:id])
		if @user.guest?
			restrict_access
		else
			respond_to do |format|
				format.html
			end
		end
	end

	def edit
		@user = User.find(params[:id])
		restrict_access unless members_page(@user)
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			if params[:user][:nav_menu]	
				respond_to do |format|
					@boolean = params[:user][:nav_menu]
					format.js
				end
			else
				respond_with @user
			end
		else 
			respond_to do |format|
		      format.html { render :action => "edit" }
		      format.json { render :json => @user.errors.full_messages, :status => :unprocessable_entity }
		    end
		end
	
	end
	
	def create 
		if current_user && current_user.guest
			cookies.delete(:auth_token)
			# redirect_to { method: :delete )
		end
		@user = params[:user] ? User.new(params[:user]) : User.new_guest
		if @user.save 
			if params[:user] #user filled out signup form
				cookies[:auth_token] = @user.auth_token
				redirect_to user_path(@user), notice: "Thank you for signing up! Once you fill out your profile and are approved, you can begin adding images"
			else
				#automatically signed up as guest
				@page = params[:page] #page user requested prior to reroute/guest sign in
				cookies[:auth_token] = @user.auth_token
				redirect_to correct_page(@page), notice: "You are logged in as a guest"
			end
		else	
			render "new"
		end
	end
end
