class Announcement < ActiveRecord::Base
  attr_accessible :message, :title
  attr_accessible :starts_at, :ends_at, :current_state, :position

  before_create :set_position
  include MyDateFormats

  
  # scope :current, -> { where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)}
  def self.current(hidden_ids = nil)
  	result = where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)
  	result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
  	result
  end

  def is_published?
    published = Status.find_by_status_name("published").id
    self.current_state == published
  end

  def self.published
    published = Status.find_by_status_name("published").id
    where(current_state: published)
  end

  def self.scheduled
    scheduled = Status.find_by_status_name("scheduled").id
    where(current_state: scheduled)
  end

  def self.draft
    draft = Status.find_by_status_name("draft").id
    where(current_state: draft)
  end

  def self.order_by_position
    order("position ASC")
  end

  private
    def set_position
      if self.current_state == 3
        self.position = (Announcement.published.count)+1
      else
        self.position = nil
      end
    end
end
