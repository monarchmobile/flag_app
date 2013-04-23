class Supermodel < ActiveRecord::Base
	attr_accessible :name, :visible


	def self.visible
		where(visible: true)
	end

	def self.hidden
		where("visible = (?)",false)
	end

end