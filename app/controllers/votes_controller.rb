class VotesController < ApplicationController
  

  def create
  	@user = current_user
  	@vote = @user.votes.build(params[:vote])
  	
  	if @vote.save
  		respond_to do |format|
  			@owner_id = params[:vote][:owner_id]
  			@range_type = params[:vote][:range_type]
	  		format.js
	  	end
  	end
  	
  end

  def update
  	@user = current_user
  	@vote = @user.votes.find(params[:id])
  	if @vote.update_attributes(params[:vote])
	  	respond_to do |format|
	  		@owner_id = @vote.owner_id
  			@range_type = @vote.range_type
	  		format.js
	  	end
	end
  end
end
