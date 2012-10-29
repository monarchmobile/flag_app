class StaticPagesController < ApplicationController
  before_filter :current_user

  def home
 
  	@user = @current_user
  	@image = Image.new
  	
  	
  end

  def scrapbook
  	@user = @current_user
  	@image = Image.new
  	
  	@scraps = @user.images.find(:all, :order => 'date_taken, id', limit: 50)
  	@scrap_days = @scraps.group_by { |t| t.date_taken.beginning_of_day }
  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end
end
