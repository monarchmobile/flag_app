class Vote < ActiveRecord::Base
  belongs_to :user
  attr_accessible :beg_range, :owner_id, :range_type, :voted 
end
