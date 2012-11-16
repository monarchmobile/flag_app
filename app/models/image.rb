class Image < ActiveRecord::Base
  attr_accessible :content, :date_taken, :week, :month, :year, :title, :url, :user_id,  :image, :remote_image_url
  
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :image, :date_taken, :title, :presence => true

  

end
