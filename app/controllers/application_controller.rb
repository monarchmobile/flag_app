class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :converted_date, :numeric, :days_array, :weeks_array, :start_week, :end_week, :start_month
  
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
  def days_array
     days = []
     @user = current_user
     user_images = @user.images.find(:all, :order => 'date_taken') 
     for image in user_images do 
       days << image.date_taken
     end 

     user_entries = @user.journals.find(:all, :order => 'entry_date') 
     for entry in user_entries do   
       days << entry.entry_date
     end 
     @days = days
  end

  ## finds all the user.images where week column is true ##
  def weeks_array
     weeks= [] 
     @user = current_user 
     user_images = @user.images.find(:all, :conditions => { week: true}) 
     for image in user_images do 
       weeks << image.date_taken 
     end 
     @weeks = weeks
  end

  ## <!-- set up parameters for weeks array --> ##
  def start_week(m) 
     date = Date.today 
     beg_month = date.beginning_of_month 
     @start_dates = [] 
     actual_month = beg_month << m 
     (1..5).each do |w| 
       @start_dates << actual_month+((w*7)-7)  
     end 
     @start_dates 
  end 

  def end_week(m) 
     date = Date.today 
     beg_month = date.beginning_of_month 
     @end_dates = [] 
     actual_month = beg_month << m 
     (1..5).each do |w| 
       @end_dates << actual_month+((w*7)-1)  
     end 
     @end_dates 
  end 

  ## set up parameters for months array ##
  def start_month(m) 
     date = Date.today 
     @beg_month = date.beginning_of_month 
     @beg_month << m  
  end 
  
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
