class UsersController < ApplicationController   
	respond_to :html, :json 
	include ApplicationHelper  
	layout :resolve_layout, :except => :new
 	before_filter :authorize, :except => [:new, :create, :coordinators ]
	def index 
		all_user_states
		
	end

	def member_index
		reset_current_state(Announcement)
		reset_current_state(Event)
		@announcements = Announcement.limit(5).order("starts_at DESC").published
		@events = Event.limit(5).order("starts_at DESC").published
		last_50_images
	end
	
	def new 
		role_choices
		@user = User.new
		
	end
	
	def show
		load_user
		if @user 
			if @user.role? :Coordinator
				coor_images
			else
				last_50_images
			end
			if @user.guest?
				restrict_access
			else
				respond_to do |format|
					format.html
				end
			end
		end
	end

	def edit
		load_user
		@programs = Program.all
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
		@programs = Program.all
		
		all_user_states
		load_user
		if params[:user][:programs]
			@program_ids = params[:user][:program_ids]
		  @user.programs = params[:user][:programs]
		end
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
				role_choices
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
			role_choices
			render :action => "new"
		end
	end

	def destroy
		load_user
		@user.destroy
		@user.program_ids=[]
		respond_to do |format|
			format.html {redirect_to dashboard_path}
			format.js
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
	

	# def all_user_states
 #    @coor_list_ints_waiting = User.not_approved.with_role(role_id(:coordinator)).where(affiliation_id: current_user.affiliation_id)
 #    @coor_list_ints_approved = User.approved.with_role(role_id(:coordinator)).where(affiliation_id: current_user.affiliation_id)
 #    @admin_list_ints_waiting = User.not_approved.with_role(role_id(:intercessor))
 #    @admin_list_coords_waiting = User.not_approved.with_role(role_id(:coordinator))
 #    @admin_list_admins_waiting = User.not_approved.with_role(role_id(:admin))
 #    @admin_list_ints_approved = User.approved.with_role(role_id(:intercessor))
 #    @admin_list_coords_approved = User.approved.with_role(role_id(:coordinator))
 #    @admin_list_admins_approved = User.approved.with_role(role_id(:admin))
   
 #  end

	def role_choices
		@admin_roles = Role.all
		@regular_roles = Role.find(:all, :conditions => ["name not IN (?)", ["Admin", "SuperAdmin"]])
		@guest_roles = Role.find(:all, :conditions => ["name IN (?)", ["Student", "Coordinator", "Host-Family"]])

		admin_id = Role.find_by_name("Admin").id
		superadmin_id = Role.find_by_name("SuperAdmin").id
	 	@master_ids = [admin_id, superadmin_id] 
	 	if current_user
		  @role_ids = current_user.role_ids 
		 	@ids = @master_ids & @role_ids.to_a
		end
	end

	def coordinators
		# @tasks = Task.find(:all, :order => 'due_at, id', :limit => 50)
  # 	@task_months = @tasks.group_by { |t| t.due_at.beginning_of_month }
		@coordinators = User.has_role("Coordinator").where(approved: true).where("state IS NOT NULL")
		@states = @coordinators.group_by { |t| t.state }
	end

	def regional_coor
		load_user
		respond_to do |format|
			if @user.update_attributes(regional_coor: params[:regional_coor])
				format.js
			end
		end
	end

	def load_user 
		@user = User.find(params[:id])
		rescue ActiveRecord::RecordNotFound
  		redirect_to root_url, :flash => { :error => "Record not found." }
	end

	def coor_images

		image_ids = Image.order("date_taken DESC").limit(50).select("id").where(user_id: @user.id)
		
		col1 = (0..(image_ids.count-1)).step(3)
		col1_array = []
		col1.each do |c1| col1_array.push(image_ids[c1]) end
		@column_one_images = Image.where("id In (?)", col1_array)

		col2 = (1..(image_ids.count-1)).step(3)
		col2_array = []
		col2.each do |c2| col2_array.push(image_ids[c2]) end
		@column_two_images = Image.where("id In (?)", col2_array)

		col3 = (2..(image_ids.count-1)).step(3)
		col3_array = []
		col3.each do |c3| col3_array.push(image_ids[c3]) end
		@column_three_images = Image.where("id In (?)", col3_array)
	end

	def last_50_images
		image_ids = Image.order("date_taken DESC").limit(50).select("id")
		
		col1 = (0..(image_ids.count-1)).step(3)
		col1_array = []
		col1.each do |c1| col1_array.push(image_ids[c1]) end
		@column_one_images = Image.where("id In (?)", col1_array)

		col2 = (1..(image_ids.count-1)).step(3)
		col2_array = []
		col2.each do |c2| col2_array.push(image_ids[c2]) end
		@column_two_images = Image.where("id In (?)", col2_array)

		col3 = (2..(image_ids.count-1)).step(3)
		col3_array = []
		col3.each do |c3| col3_array.push(image_ids[c3]) end
		@column_three_images = Image.where("id In (?)", col3_array)
	end
end
