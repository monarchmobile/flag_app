class StaticPagesController < ApplicationController
  before_filter :current_user, :days_array, :weeks_array

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
    if params[:date]
      date = (params[:date])
    
      @user_images = @user.images.find_all_by_date_taken(date)
      @user_journals = @user.journals.find_all_by_entry_date(date)

    else
      @user_images = @user.images.find_all_by_date_taken(Date.today)
      @user_journals = @user.journals.find_all_by_entry_date(Date.today)
    end

  end

  def weekly
    user_setup
    if params[:start_week] && params[:end_week]
      start_week = (params[:start_week])
      end_week = (params[:end_week])
      @user_images = @user.images.where({:date_taken => start_week..end_week, week: true})
    else
      @user_images = @user.images.where({:date_taken => start_week(0)[1]..end_week(0)[1], week: true})
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
