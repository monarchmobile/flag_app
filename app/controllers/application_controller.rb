class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :converted_date, :correct_image, :restrict_access
  def converted_date(date)
  	date.split(' ')[0]
  end

  ## Varaiables used for staticpagesController (daily, weekly, monthly, yearly)
  def correct_image(num)
    :landscape if num  == 1 || num == 2
    :portrait if num   == 3
    :mini if num  == 4 || num == 5
  end

  def restrict_access
    redirect_to root_path, :notice => "Access denied"
  end

private 
  def current_user 
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  	
  	helper_method :current_user
  	
  	def authorize
  		redirect_to login_url, alert: "Not authorized" if current_user.nil?
  	end
  	
  	def current_user?(user)
    	user == current_user
  	end

    helper_method :current_user?

    def login_user(user)
      if user && user.authenticate(params[:password])
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        redirect_to root_path
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end
     helper_method :login_user 

end
