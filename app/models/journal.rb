class Journal < ActiveRecord::Base
  attr_accessible :content, :user_id, :entry_date
  
  belongs_to :user
end
