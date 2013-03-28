class StatusesController < ApplicationController

	before_filter :load_statusable

	def index
		@statuses = @statusable.statuses
	end

	def new
		@status = @statusable.statuses.new
	end

	def create
		@status = @statusable.statuses.new(params[:status])
		if @status.save
		  redirect_to @statusable, notice: "Status created."
		else
		  render :new
		end
	end

	private

	  def load_statusable
	    resource, id = request.path.split('/')[1, 2]
	    @statusable = resource.singularize.classify.constantize.find(id)
	  end

end