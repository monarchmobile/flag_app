class UsersController < ApplicationController   
	respond_to :html, :json 
	include ApplicationHelper  
	layout :resolve_layout, :except => :new
 
	def index 
		all_user_states
	end

	def member_index
		@announcements = Announcement.all
		@events = Event.all
		
	end
	
	def new 
		role_choices
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
		role_choices
		if members_page(@user) 
			@roles = Role.find(:all, :conditions => ["name IN (?)", ["Student", "Staff"]])
			users_path(@user) 
		elsif current_user.role? :Admin
			
			users_path(@user)
		else
			restrict_access 
		end
	end

	def update
		all_user_states
		@user = User.find(params[:id])
		if params[:user][:approved] == true
			@user.guest = false
		end
		
		if @user.update_attributes(params[:user])
			if params[:user][:nav_menu]	|| params[:user][:approved]
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
		if params[:user][:role_ids]
      @user.role_ids = params[:user][:role_ids]
      @user.guest = false
    end
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

	def sort
    all_user_states
    params[:user].each_with_index do |id, index|
      User.update_all({position: index+1}, {id: id})
    end
    render "update.js"
  end

	def all_user_states
		@approved_users = User.approved_users
		@users_waiting_to_be_approved = User.users_waiting_to_be_approved
	end

	def role_choices
		@admin_roles = Role.all
		@regular_roles = Role.find(:all, :conditions => ["name not IN (?)", ["Admin", "SuperAdmin"]])
		@guest_roles = Role.find(:all, :conditions => ["name IN (?)", ["Student", "Coordinator", "Host-Family"]])

		admin_id = Role.find_by_name("Admin").id
		superadmin_id = Role.find_by_name("SuperAdmin").id
	 	@master_ids = [admin_id, superadmin_id] 
	  @role_ids = current_user.role_ids
	 	@ids = @master_ids & @role_ids.to_a
	end
end
