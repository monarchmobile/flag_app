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
  	@vote = Vote.find(params[:id])
  	respond_to do |format|
  		if @vote.update_attributes(params[:vote])
  		
  			format.js
  		end
  	end
  end
end
