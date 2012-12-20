class UsersController < ApplicationController
	respond_to :html, :json
	include ApplicationHelper

	def index 
		redirect_to create_guest_path unless current_user
		@users = User.find(:all, :conditions => "email IS NOT NULL")
		@page = params[:page]
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
		if params[:user][:nav_menu]
			@user.update_attributes(params[:user])
			respond_to do |format|
				@boolean = params[:user][:nav_menu]
				format.js
			end
		else
			@user.update_attributes(params[:user])
			respond_with @user
		end
	end
	
	def create 
		@user = params[:user] ? User.new(params[:user]) : User.new_guest
		if @user.save 
			if params[:user] #user filled out signup form
				cookies.permanent[:auth_token] = @user.auth_token
				redirect_to edit_user_path(@user), notice: "Thank you for signing up! Please fill out required fields for full functionality"
			else
				#automatically signed up as guest
				@page = params[:page] #page user requested prior to reroute/guest sign in
				cookies.permanent[:auth_token] = @user.auth_token
				redirect_to correct_page(@page), notice: "You are logged in as a guest"
			end
		else	
			render "new"
		end
	end
end
