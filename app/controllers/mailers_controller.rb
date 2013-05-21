class MailersController < ApplicationController

	def coordinator_message
		respond_to do |format|
			format.js
		end
	end

end