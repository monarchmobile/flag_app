class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password_confirmation, :password, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :country, :cell, :phone, :school, :family, :user_type, :nav_menu, :member_photo
  # has_secure_password
  before_create { generate_token(:auth_token) }
  before_create { set_nav_menu_to_true }

  validates :last_name,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :presence => {:message => "can't be blank"}, unless: :guest?
  validates :first_name,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :presence => {:message => "can't be blank"}, unless: :guest?
  validates :city,
    :length => { :minimum => 2, :maximum => 24, :message => "has invalid length"},
    :presence => {:message => "can't be blank"}, unless: :guest?

  validates_presence_of :email, :password_digest, unless: :guest?
  validates_confirmation_of :password

  # pretty url
  extend FriendlyId
  friendly_id :last_name

  # profile pic
  mount_uploader :member_photo, ProfilepicUploader

  # override has_secure_password to customize validation until Rails 4.
  require 'bcrypt'
  attr_reader :password
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation
  
  has_many :images 
  has_many :journals
  has_many :scrapbooks

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
  def full_name
    if !first_name.nil? && !last_name.nil?
      "#{first_name} #{last_name}"
    else
      "#{email}"
    end
  end

end
