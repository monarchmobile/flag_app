class SupermodelsController < ApplicationController

	# layout 'dashboard'

	def new 
		@supermodel = Supermodel.new
	end

	def index 
		@supermodels = Supermodel.all(:order => "visible ASC, name ASC")
	end

	def show
		find_supermodel
	end

	def create
		@supermodel = Supermodel.find(params[:supermodel])
		respond_to do |format|
			if @supermodel.save
				format.html { redirect_to dashboard_path, "model saved" }
				format.js
			else
				format.html { render 'new', notice: "model not saved" }
				format.js
			end
		end
	end

	def edit
		find_supermodel 

	end

	def update
		find_supermodel
		authorize! :update, @supermodel

		respond_to do |format|
	      if @supermodel.update_attributes(params[:supermodel])
	        format.html { redirect_to dashboard_path, notice: 'model was successfully updated.' }
	        format.js
	      else
	        format.html { render action: "edit" }
	        format.js { render json: @supermodel.errors, status: :unprocessable_entity }
	      end
	    end

	end




	def find_supermodel
		@supermodel = Supermodel.find(params[:id])
	end


end
