class Journal < ActiveRecord::Base
  attr_accessible :content, :user_id, :entry_date, :day, :week, :month, :year
  
  belongs_to :user
end
