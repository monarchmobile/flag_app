class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :publish_to_web, :pull_from_web, :title, :status_ids

  has_many :statuses_statusables, as: :statusable, :dependent => :destroy
  has_many :statuses, :through => :statuses_statusables

end
