class ProgramsController < ApplicationController 
	layout 'dashboard'
	authorize_resource
	def new 
		@program = Program.new	
	end

	def index
		@programs = Program.all 
	end

	def show 
		find_program
	end

	def edit 
		find_program
	end

	def create 
		@program = Program.new(params[:program])
		respond_to do |format|
			if @program.save
				format.html { redirect_to @program, :notice => "The #{@program.name} program was successfully created" }
				format.js
			else
				format.html { redirect_to "new", :notice => "program could not be created. Please fill out all ** fields"}
			end
		end
	end

	def update
		find_program
		respond_to do |format|
			if @program.update_attributes(params[:program])
				format.html { redirect_to @program, :notice => "The #{@program.name} program was succesfully updated"}
				format.js
			else
				format.html { render :action => "edit"}
			end
		end
	end

	def destroy
		find_program
		@program.destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js
		end
	end

	def find_program 
		@program = Program.find(params[:id])
	end

end