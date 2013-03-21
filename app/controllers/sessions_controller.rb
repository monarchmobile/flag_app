class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js
      format.
    end 
  end
  
  def create
    @user = User.find_by_email(params[:email])
    login_user(@user)
  end
  
  def destroy 
  	cookies.delete(:auth_token)
  	redirect_to root_url, notice: "Logged out!"
  end
end
