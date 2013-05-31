class Page < ActiveRecord::Base 
  attr_accessible :content, :position, :current_state, :slug, :title, :starts_at, :ends_at
  attr_accessible :link_ids, :partial_ids
  before_create :make_slug
  # validates :slug, :uniqueness => true
  # before_save :set_position

  has_many :links_pages, :dependent => :destroy
  has_many :links, :through => :links_pages

  has_many :page_partials 
  has_many :partials, :through => :page_partials

  def locations?(location)
     return !!self.links.find_by_location(location.to_s)
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

  # pretty url
  extend FriendlyId
  friendly_id :slug

  private
    def make_slug
      self.slug = self.title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    end

    def set_position
      if self.current_state == 3
        self.position = (Describe.new(Page).published.count)+1
      else
        self.position = nil
      end
    end

end
