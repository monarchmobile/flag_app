class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :converted_date, :correct_image
  def converted_date(date)
  	date.split(' ')[0]
  end

  ## Varaiables used for staticpagesController (daily, weekly, monthly, yearly)
  def correct_image(num)
    :landscape if num  == 1 || num == 2
    :portrait if num   == 3
    :mini if num  == 4 || num == 5
  end

private 
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  	
  	helper_method :current_user
  	
  	def authorize
  		redirect_to login_url, alert: "Not authorized" if current_user.nil?
  	end
  	
  	def current_user?(user)
    	user == current_user
  	end
    helper_method :current_user?
    
end
