class PagesController < ApplicationController 
	# load_and_authorize_resource
	layout :resolve_layout
	def new 
		@page = Page.new
		@links = Link.all
	end

	def index
		@pages = Page.all 
	end

	def show 
		find_page
		
		
	end

	def edit 
		find_page
		@links = Link.all
	end

	def create 
		@page = Page.new(params[:page])
		respond_to do |format|
			if @page.save
				format.html { redirect_to @page, :notice => "The #{@page.title} page was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "page could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		find_page
		respond_to do |format|
			if @page.update_attributes(params[:page])
				format.html { redirect_to @page, notice: "changes saved" }
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		find_page
		@page.destroy
		respond_to do |format|
			format.html { redirect_to dashboard_path, :notice => "The #{@page.title} page was successfully deleted" }
			format.js
		end
	end

	def find_page 
		@page = Page.find(params[:id])
	end

	

end