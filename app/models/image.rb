class Image < ActiveRecord::Base 
  
  attr_accessible :content, :date_taken, :week, :month, :year, :title, :url, :user_id, :image, :crop_x, :crop_y, :crop_w, :crop_h, :day_p, :week_p, :month_p, :year_p, :day_dim, :week_dim, :month_dim, :year_dim, :nav_menu
  attr_accessible :day_z, :week_z, :month_z, :year_z
  validates :image, :date_taken,  :presence => true
  belongs_to :user
  include ApplicationHelper
  
  mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  
  def crop_avatar
    image.recreate_versions! if crop_x.present?
  end

  def set_nav_menu_to_true
    self.nav_menu = true 
  end

  def self.for_this_range(beg_range, end_range, range)
      where(date_taken: beg_range..end_range, range.to_sym => true ).order("date_taken ASC")
  end
 
  def self.range?(range)
    range.to_sym == true
  end 

end
