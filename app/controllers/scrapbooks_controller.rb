class ScrapbooksController < ApplicationController
  # Index 
  def index
    @user = User.find(params[:id])
    @scrapbooks = @user.scrapbooks.all
  end

  # set environment vars for every scrapbook page (day, week, month, year)
  def set_scrapbook_vars #**** should be moved to application_controller
    @user = User.find(params[:id])
    @time = request.path.split("/")[4]  
    @nav_menu = @user.nav_menu
  end

  # set params if params[:beg_range] exists
  def params_vars #**** should be moved to application_controller
    @beg_range = params[:beg_range]
    @end_range = params[:end_range]
    @bread_crumb = params[:bread_crumb]
  end
 
  def day
    set_scrapbook_vars
    if params[:beg_range]
      params_vars
     
      @user_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, day: true)
      
    else
      @beg_range = Date.today
      @end_range = Date.today
      @user_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, day: true)
    end

    respond_to do |format| 
      format.html { render 'day'}
      format.js
    end
  end

  def week
    set_scrapbook_vars
    if params[:beg_range]
      params_vars

      @user_images = @user.images.for_this_range(@beg_range, @end_range, "week")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, week: true)
      
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "week")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, week: true)
    end

    respond_to do |format| 
      format.html { render 'day'}
      format.js
    end
  end

  def month
    set_scrapbook_vars
    if params[:beg_range]
      params_vars

      @user_images = @user.images.for_this_range(@beg_range, @end_range, "month")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range, week: true).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, month: true)
      
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "month")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range, week: true).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, month: true)
     
    end
    respond_to do |format| 
      format.html { render 'day'}
      format.js
    end
  end

  def year
  
    set_scrapbook_vars
    if params[:beg_range]
      params_vars

      @user_images = @user.images.for_this_range(@beg_range, @end_range, "year")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, year: true )
      
    else
      @beg_range = Date.today.beginning_of_week
      @end_range = Date.today.end_of_week
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "year")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, year: true)
     
    end
    respond_to do |format| 
      format.html { render 'day'}
      format.js
    end
  end

  

end
