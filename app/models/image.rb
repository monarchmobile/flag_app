class Image < ActiveRecord::Base
  attr_accessible :content, :date_taken, :week, :month, :year, :title, :url, :user_id,  :image, :remote_image_url
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :image, :date_taken, :title, :presence => true

  

end
