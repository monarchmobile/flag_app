class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :publish_to_web, :pull_from_web, :title
end
