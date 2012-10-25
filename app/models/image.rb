class Image < ActiveRecord::Base
  attr_accessible :content, :date_taken, :month, :title, :url, :user_id, :week, :year, :image
  
  belongs_to :user
  #mount_uploader :image, ImageUploader
end
