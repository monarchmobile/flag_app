class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password_confirmation, :password, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :country, :cell, :phone, :school, :family, :user_type, :nav_menu
  has_secure_password
  before_create { generate_token(:auth_token) }
  before_create { set_nav_menu_to_true }
  validates_uniqueness_of :email
  
  has_many :images 
  has_many :journals
  has_many :scrapbooks

  def set_nav_menu_to_true
    self.nav_menu = true
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def has_not_reached_daily_image_limit?(d)
      images.where(:date_taken => d).count < 5
  end

  def monthly_image_submissions
    images.find(:all, :conditions => {month: true})
  end

end
