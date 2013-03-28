class Status < ActiveRecord::Base
  attr_accessible :current_state

  has_many :statuses_statusables, :dependent => :destroy
  has_many :statusables, :through => :statuses_statusables


end
