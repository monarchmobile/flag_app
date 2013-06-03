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
    static_array = %w[Partial Profile Role Supermodel]
    @active_models = Supermodel.where("visible = true AND name NOT IN (?)", static_array).order("name ASC")
    @static_models = Supermodel.where("visible = true AND name IN (?)", static_array).order("name ASC")
  end

end
