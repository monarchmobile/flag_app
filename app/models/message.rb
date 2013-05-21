class Message < ActiveRecord::Base
	attr_accessible :content, :user_id
	attr_accessible :from_first_name, :from_last_name, :from_email, :from_phone_number 

	belongs_to :user

	def send_coordinator_email
    UserMailer.coordinator_message(self).deliver
  end

end