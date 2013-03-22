class Page < ActiveRecord::Base
  attr_accessible :content, :position, :published, :slug, :title

  before_create :make_slug
  # validates :slug, :uniqueness => true

  # pretty url
  extend FriendlyId
  friendly_id :slug

  def self.s_that_are_published
    where(:published => true).order("position ASC")
  end

  def self.published?
    wher(:published => true)
  end

  private
	  def make_slug
	    self.slug = self.title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
	  end
end
