class StaticPagesController < ApplicationController
  before_filter :current_user, :except => [:home]
  layout 'dashboard'
  include ApplicationHelper

  

  def profile
    @page = page_requested
    redirect_to create_guest_path(page: @page) unless current_user
  	@user = @current_user
  end

  def about
    @page = page_requested
    redirect_to create_guest_path(page: @page) unless current_user
  	@user = @current_user
  end

  def book
    @page = page_requested
    redirect_to create_guest_path(page: @page) unless current_user
    @user = @current_user
  end

  def dashboard
    @pages = Page.all
    # @page = Page.new
    @announcements = Announcement.all 
    # @announcement = Announcement.new
    @events = Event.all 
    # @event = Event.new
    @users = User.where({approved: false, guest: false})
    @visible_models = Supermodel.where(visible: true)
  end

 

  
  

end
