class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password_confirmation, :password
  
  has_secure_password
  
  validates_uniqueness_of :email
  
  has_many :images
  has_many :journals


  def has_not_reached_daily_image_limit?(d)
      images.where(:date_taken => d).count < 5
  end

  date = Date.today
  @date = date
  beg_month = date.beginning_of_month
  @beg_month = beg_month

  @prev_months = [] 
  (1..12).each do |m| 
  	@prev_months << beg_month.prev_month(m) 
  end 

  @start_dates = [] 
  @end_dates = [] 
  (1..5).each do |w| 
	  @start_dates << beg_month+((w*7)-7)
	  @end_dates << beg_month+(w*7)-1
  end

  def images_for_this_week(d)
  	  images.find(:all, :conditions => {:date_taken => @start_dates[d]..@end_dates[d]})
  end 


 

end
