class ScrapbooksController < ApplicationController
  # Index 
  def index
    @user = User.find(params[:id])
    @scrapbooks = @user.scrapbooks.all
  end
 
  def day  
    @user = User.find(params[:id])
  
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range]
    
      @user_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, day: true)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
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
    @user = User.find(params[:id])
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range]
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "week")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, week: true)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
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
    @user = User.find(params[:id])
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range] 
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "month")
      @month_images = @user.images.where(date_taken: @beg_range..@end_range, week: true).order("date_taken ASC")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, month: true)
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
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
    @user = User.find(params[:id])
    if params[:beg_range]
      @beg_range = params[:beg_range]
      @end_range = params[:end_range] 
      @user_images = @user.images.for_this_range(@beg_range, @end_range, "year")
      @journal = @user.journals.where(entry_date: @beg_range..@end_range, year: true )
      if params[:bread_crumb]
        @bread_crumb = params[:bread_crumb]
      end
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
