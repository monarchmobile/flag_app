class Scrapbook < ActiveRecord::Base
  attr_accessible :period, :user_id

  belongs_to :user
end
