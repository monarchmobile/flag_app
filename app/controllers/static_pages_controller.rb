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
    @user = @current_user

    
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range]
    
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)

    else
      @beg_range = Date.today
      @end_range = Date.today
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.find_all_by_entry_date(@beg_range..@end_range)
    end

    respond_to do |format| 
      format.html
      format.js
    end

  end

  def weekly
    user_setup
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range]
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
    end

    respond_to do |format| 
      format.html
      format.js
    end

  end

  def monthly
    user_setup
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range] 
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
     
    end
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def yearly
    user_setup
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range] 
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.where(date_taken: @beg_range..@end_range)
      @journal = @user.journals.where(entry_date: @beg_range..@end_range)
     
    end
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  # finding all days that have either images or journal entried #
  

  
end
