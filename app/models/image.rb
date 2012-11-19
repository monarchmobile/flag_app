class Image < ActiveRecord::Base
  
  attr_accessible :content, :date_taken, :week, :month, :year, :title, :url, :user_id, :image, :crop_x, :crop_y, :crop_w, :crop_h
  validates :image, :date_taken,  :presence => true
  belongs_to :user

  
  mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  
  def crop_avatar
    image.recreate_versions! if crop_x.present?
  end

  

  

end
