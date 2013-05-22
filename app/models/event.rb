class Event < ActiveRecord::Base 
  attr_accessible :title, :slug, :body, :event_start, :event_end, :featured
  attr_accessible :starts_at, :ends_at, :current_state, :position

	before_create :make_slug, :set_position

  validates_presence_of :title, :body
	validates_uniqueness_of :title


	include MyDateFormats

	scope :featured, where(:featured => true)


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

  def create_date(date)
    if date.to_s == "starts_at"
      new_date = Date.today
    elsif date.to_s == "ends_at"
      new_date = Date.today+30.days
    end
    return new_date
  end

	private

	def make_slug
    self.slug = self.title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def set_position
    self.position = (Event.published.count)+1
  end	
end
