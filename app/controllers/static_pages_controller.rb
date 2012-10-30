class StaticPagesController < ApplicationController
  before_filter :current_user

  def home
 
  	@user = @current_user
  	@image = Image.new
  	
  	
  end

  def scrapbook
  	@user = @current_user
  	@image = Image.new
  	@journal = Journal.new
  	
  	# @scrap_images = @user.images.find(:all, :order => 'date_taken, id')
#   	
#   	
#   	@scrap_entries = @user.journals.find(:all, :order => 'entry_date, id', limit: 1)
#   	
#   	
#   	@days_with_scrap_images = @scrap_images.group_by { |t| t.date_taken } 
#   	@days_with_scrap_entries = @scrap_entries.group_by {|t| t.entry_date.beginning_of_day }
#   	
#   	 @days = [] 
# 
# 	 @days_with_scrap_images.each do |day, scrap_images| 	
# 		 @days << day 	
# 	 end 
# 	 @days_with_scrap_entries.each do |day, scrap_entries| 	
# 		 @days << day 	
# 	 end 
	
	 
  	
  	
  	
	
  	
  	
  	
  	#@days_with_scraps = @days_with_scrap_images|| @days_with_scrap_entries  	
   	
  	
  	
  	
  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end
end
