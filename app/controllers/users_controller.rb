class UsersController < ApplicationController
	respond_to :html, :json

	def index 
		@users = User.all 
	end
	
	def new
		@user = User.new
	end
	
	def show
		@user = User.find(params[:id])
		respond_to do |format|
			format.html
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])	
		if params[:user][:nav_menu]
			@boolean = params[:user][:nav_menu]
			@user.update_attributes(params[:user])
		else
			respond_with @user
		end
	end
	
	def create 
		@user = User.new(params[:user])
		if @user.save 
			redirect_to root_url, notice: "Thank you for signing up"
		else	
			render "new"
		end
	end
end
