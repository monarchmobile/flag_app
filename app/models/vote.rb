class Vote < ActiveRecord::Base
  belongs_to :user
  attr_accessible :beg_range, :owner_id, :range_type, :voted

  scope :votes_for, count(:group => "owner_id")
end
