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

  end

  def weekly
    user_setup
  end

  def monthly
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
