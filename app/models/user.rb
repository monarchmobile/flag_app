class User < ActiveRecord::Base 
  # attributes by row %w[ stock admin added virtual ]
  attr_accessible :email, :first_name, :last_name, :password_confirmation, :password
  attr_accessible :user_type, :guest
  attr_accessible :address1, :address2, :city, :state, :zip, :country, :cell, :phone, :school, :family, :nav_menu, :member_photo
  # attr_accessible :
  # has_secure_password
  before_create { generate_token(:auth_token) }
  before_create { set_nav_menu_to_true }
    
  validates_presence_of :password_digest, :first_name, :last_name, unless: :guest?
  validates_confirmation_of :password
  validates :email, :email_pattern => true, unless: :guest?

  validates :last_name,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :presence => {:message => "can't be blank"},
    :on => :update,
    unless: :guest?

  validates :first_name,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :presence => {:message => "can't be blank"},
    :on => :update,
    unless: :guest?
    
  validates :city,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :allow_blank => true,
    :on => :update,
    unless: :guest?
   

  def requireds_are_blank
    required_fields = %W(first_name, last_name, city)
    required_fields.each do |r|
      r.blank?
    end
    # errors.add(:base, "Msg") 
    # last_name.blank? && first_name.blank? && city.blank?  
  end

  # pretty url
  # extend FriendlyId
  # friendly_id :last_name

  # profile pic
  mount_uploader :member_photo, ProfilepicUploader


  # override has_secure_password to customize validation until Rails 4.
  require 'bcrypt'
  attr_reader :password
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation
  
  has_many :images 
  has_many :journals
  has_many :scrapbooks
  has_many :votes

  # set nav_menu boolean to true
  def set_nav_menu_to_true
    self.nav_menu = true 
  end

  # send email to user to reset password
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

  def self.new_guest
    new { |u| u.guest = true }
  end

  # current_user ? full_name : Guest
  def name
    guest ? "Guest" : full_name
  end

  # current_user has filled out form? "first_name last_name" : email
  def fullname 
    [first_name, last_name].join(" ")
  end

  def fullname=(name)
    split = name.split(" ", 2)
    self.first_name = split[0]
    self.last_name = split[1]
  end

  

end
