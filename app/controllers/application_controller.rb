class ApplicationController < ActionController::Base
  # Don't let controllers get away with 
  # any monkey business
  
  protect_from_forgery
  include ApplicationHelper

  helper_method :converted_date, :correct_image, :restrict_access, :current_vote, :resolve_layout
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

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def resolve_layout
    case action_name
    when "show"
      "application"
    when "index", "edit", "new"
      "dashboard"
    else
      "application"
    end
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
        redirect_to user_path(user)
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end
     helper_method :login_user 


end
