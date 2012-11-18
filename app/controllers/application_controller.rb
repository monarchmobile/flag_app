class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :converted_date
  
  def converted_date(date)
  	date.split(' ')[0]
  end

  ## Varaiables used for staticpagesController (daily, weekly, monthly, yearly)
  def user_setup
    @user = current_user
    @image = @user.images.new
    @journal = @user.journals.new
  end
   
  ## finds all the user.images where day column is true ##
 
 
 
  
  

  ## date comes in timestamp.  This converts to usable date. Used in _week, _month, _year ##

private 
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
  	
  	helper_method :current_user
  	
  	def authorize
  		redirect_to login_url, alert: "Not authorized" if current_user.nil?
  	end
  	
  	def current_user?(user)
    	user == current_user
  	end

    
end
