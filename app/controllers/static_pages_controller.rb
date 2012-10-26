class StaticPagesController < ApplicationController
  before_filter :current_user

  def home
 
  	@user = @current_user
  	@image = Image.new
  	
  	
  end

  def scrapbook
  	@user = @current_user
  	@image = Image.new
  end

  def profile
  	@user = User.find(params[:user_id]) if params[:user_id]
  end

  def about
  	@user = User.find(params[:user_id]) if params[:user_id]
  end
end
