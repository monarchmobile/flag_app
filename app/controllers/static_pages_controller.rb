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
  	
    # finding all days that have either images or journal entried #
  	 days = [] 
     user_images = @user.images.find(:all, :order => 'date_taken') 
     for image in user_images do 
       days << image.date_taken
     end 

     user_entries = @user.journals.find(:all, :order => 'entry_date') 
     for entry in user_entries do   
       days << entry.entry_date
     end 
     @days = days

     # finding all weeks that have either images or journal entried #
     


  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  
end
