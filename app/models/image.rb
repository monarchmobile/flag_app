class Image < ActiveRecord::Base
  attr_accessible :content, :date_taken, :month, :title, :url, :user_id, :week, :year
  
  belongs_to :user
end
