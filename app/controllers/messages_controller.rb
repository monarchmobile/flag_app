class MessagesController < ApplicationController
	authorize_resource
	def new
		coor = params[:coor]
		@user = User.find(coor)
		@message = @user.messages.new
	end

	def index
		@messages = Message.all 
	end

	def show
		find_message
	end

	def edit
		find_message
	end

	def create
		@user = User.find(params[:user_id])
		@message = @user.messages.new(params[:message])
		respond_to do |format|
			if @message.save
				@message.send_coordinator_email
				format.html { redirect_to root_path, :notice => "message was sent to " }
				format.js
			else
				format.html { render action: "new" }
	      format.json { render json: @link.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		find_message
		respond_to do |format|
			if @message.update_attributes(params[:message])
				format.html { redirect_to messages_path }
				format.js
			else
				format.html
				format.js
			end
		end
	end

	def destroy
		find_message
		@message.destroy
		respond_to do |format|
			format.html { redirect_to messages_path }
			format.js
		end
	end

	def find_message
		@message = message.find(params[:id])
	end
end