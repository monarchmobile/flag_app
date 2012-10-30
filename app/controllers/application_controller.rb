class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def converted_date(date)
  	date.split(' ')[0]
  end
  
  helper_method :converted_date
  
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
