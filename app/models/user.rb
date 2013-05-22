class User < ActiveRecord::Base  
  # attributes by row %w[ stock admin added virtual ]
  attr_accessible :email, :first_name, :last_name, :password_confirmation, :password, :username
  attr_accessible :roles, :approved, :role_ids, :position, :program_ids
  attr_accessible :address1, :address2, :city, :state, :zip, :country, :cell, :phone, :school, :family, :nav_menu, :member_photo
  attr_accessible :user_type, :guest, :host_state, :host_country
  attr_accessible :regional_coor, :flag_comments, :hobbies
  # attr_accessible :
  # has_secure_password
  before_create { generate_token(:auth_token) }
  before_create { set_nav_menu_to_true }
  before_create :setup_role

  has_many :messages

  has_and_belongs_to_many :roles
  has_many :user_programs
  has_many :programs, :through => :user_programs
    
  validates_presence_of :password_digest, :first_name, :last_name, :state, unless: :guest?
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
  
  has_many :images, :dependent => :destroy
  has_many :journals, :dependent => :destroy
  has_many :scrapbooks
  has_many :votes

  scope :has_role, lambda{|role| includes(:roles).where(:roles => { :name => role })}

  def role_is(role)
    type = Role.find_by_name(role).id
    where(self.role_ids.include?(type))
  end

  def is_approved?
    self.approved == true
  end

  def is_published?
    published = Status.find_by_status_name("published").id
    self.current_state == published
  end

  def self.approved_users
    where(approved: true)
  end

  def self.users_waiting_to_be_approved
    where(approved: false, guest: false)
  end

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
    guest = Role.find_by_name("Guest").id
    new { |u| u.role_ids = [guest] }
  end

  # current_user ? full_name : Guest
  def name
    guest ? "Guest" : fullname
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

  def role?(role)
   return !!self.roles.find_by_name(role.to_s)
  end

  private
    def setup_role
      role = Role.find_by_name("Guest")

      if self.role_ids.empty?
        self.role_ids = [role.id]
      end
    end
  

end
