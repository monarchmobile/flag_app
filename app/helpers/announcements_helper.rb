module AnnouncementsHelper
	def object_status(object)
		status_id = object.status_ids.first.to_i
		@status = Status.find(status_id)
		@status.current_state
	end
end
