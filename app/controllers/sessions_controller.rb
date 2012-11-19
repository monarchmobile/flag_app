class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  
  end
  
  def create 
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id 
  		@user = user
  		redirect_to root_url, notice: "Logged In!"
  	else
  	 	flash.now.alert = "Email or password is invalid"
  	 	render "new"
  	end
  end
  
  def destroy 
  	session[:user_id] = nil 
  	redirect_to root_url, notice: "Logged out!"
  end
end
