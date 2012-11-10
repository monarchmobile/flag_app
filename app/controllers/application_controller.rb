class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :converted_date, :numeric, :days_array, :weeks_array, :start_week, :end_week, :start_month, :play_nice_date
  
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

  ## date comes in timestamp.  This converts to usable date. Used in _week, _month, _year ##
  def play_nice_date(d)
    nice_date = d.strftime('%d').to_i 
     w = nice_date/7 

    ##<!-- get m value --> ##
     date1 = Date.today 
     date2 = Date.today.beginning_of_month 
     breaker = date1.strftime("%d").to_i  ##<!-- today's number day of month --> ##

    ##<!-- days of current month -->##
     count = (date1.beginning_of_month..(date1.next_month.beginning_of_month-1)).count 
     answer = distance_of_time_in_words(date1, d) 
     number = answer.split(' ')[0].to_i 
     word = answer.split(' ')[1] 
        ##<!-- test if we are in present month-set m to 0 -->##
    if number < breaker 
       m = 0 
    else 
       ##<!-- get into next month and get a clean num for how many months away -->##
       date3 = Date.today.next_month-number+1 
       answer2 = distance_of_time_in_words(date3, d) 
       number2 = answer2.split(' ') 
       for num in number2 do 
         if is_numeric?(num) 
           m = num.to_i 
         end 
       end 
    end 
    m
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
