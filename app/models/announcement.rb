class Announcement < ActiveRecord::Base
  attr_accessible :message, :title
  attr_accessible :starts_at, :ends_at, :current_state, :position
  attr_accessible :send_at, :send_list, :sent, :send_list_array

  before_create :set_position
  before_update :check_current_state
  include MyDateFormats

  
  # scope :current, -> { where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)}
  def self.current(hidden_ids = nil)
  	result = where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)
  	result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
  	result
  end

  def send_list_array=(ids)
    self.send_list = ids.join(',')
  end

  # turn into array
  def send_list_array
    new_array = []
    if self.send_list.length > 0
      group_array = self.send_list.split(',').to_a
      group_array.each do |g|
        new_array.push(g.to_i)
      end
    end
      
    return new_array
  end

  def check_current_state
    published = Status.find_by_status_name("published").id 
    scheduled = Status.find_by_status_name("scheduled").id 
    draft = Status.find_by_status_name("draft").id 
    if (self.current_state ==  published) 
      set_position
      if self.starts_at.blank?
        self.starts_at = Date.today
      end
    elsif self.current_state == scheduled
      set_position
    elsif self.current_state == draft
      set_position
      self.ends_at = nil
      self.starts_at = nil
    end
  end

  def expired?(date)
    date < Date.today
  end

  # send email for published annoucement
  def send_announcement_email
    if self.sent == false
      UserMailer.announcement_notice(self).deliver
    end
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
        self.position = (Describe.new(Announcement).published.count)+1
      else
        self.position = nil
      end
    end
end
