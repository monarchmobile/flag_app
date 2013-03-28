class LinksPage < ActiveRecord::Base
  # attr_accessible :title, :body 

  belongs_to :link 
  belongs_to :page 

end
