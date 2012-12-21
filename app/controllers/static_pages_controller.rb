class StaticPagesController < ApplicationController
  before_filter :current_user, :except => [:home]
  include ApplicationHelper

  def home
  	@user = @current_user
  end

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

end
