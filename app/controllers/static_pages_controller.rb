class StaticPagesController < ApplicationController
  before_filter :current_user, :days_array, :weeks_array, :except => [:home]

  def home
 
  	@user = @current_user
  	@image = Image.new
  	
  	
  end

  def scrapbook
  	@user = @current_user
  	@image = @user.images.new
  	@journal = Journal.new

  	
  end
  
  def daily
    user_setup
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range]
    
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @user_journals = @user.journals.where(entry_date: @beg_range..@end_range)

    else
      @beg_range = Date.today
      @end_range = Date.today
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @user_journals = @user.journals.where(entry_date: @beg_range..@end_range)
      @answer = ""
    end

    respond_to do |format| 
      format.html
      format.js
    end

  end

  def weekly
    user_setup
    @first_week = Date.today.beginning_of_month.beginning_of_week
    @beg_of_month = @first_week.next_week.beginning_of_month
    if params[:start_week] && params[:end_week]
      beg_of_week = (params[:start_week])
      end_of_week = (params[:end_week])
      beg_month = (params[:beg_month])
      @user_images = @user.images.where({:date_taken => beg_of_week..end_of_week, week: true})  
      
    else
      @user_images = @user.images.where({:date_taken => start_week(0)[1]..end_week(0)[1], week: true})
      
      @start_month = Date.today.beginning_of_month
      @previous_month = Date.today.beginning_of_month.prev_month
      @next_month = Date.today.beginning_of_month.next_month
    end


    respond_to do |format| 
      format.html
      format.js
    end

  end

  def monthly
    user_setup
   if params[:start_month] && params[:end_month]
      start_month = (params[:start_month])
      end_month = (params[:end_month])
      @user_images = @user.images.where({:date_taken => start_month..end_month, month: true})
    else
      @user_images = @user.images.where({:date_taken => start_month(0)..(start_month(0).next_month-1), month: true})
    end

    respond_to do |format| 
      format.html
      format.js
    end
  end

  def yearly
    user_setup
  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  # finding all days that have either images or journal entried #
  

  
end
