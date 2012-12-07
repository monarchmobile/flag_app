class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password_confirmation, :password, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :country, :cell, :phone, :school, :family, :user_type
  
  has_secure_password
  
  validates_uniqueness_of :email
  
  has_many :images
  has_many :journals


  def has_not_reached_daily_image_limit?(d)
      images.where(:date_taken => d).count < 5
  end

  def monthly_image_submissions
    images.find(:all, :conditions => {month: true})
  end

  def monthly_image_submissions_within_range(m,w)
    images.find(:all, conditions: {date_taken: start_week(month)[0]..end_week(month)[0], month: true})
  end



 

end
