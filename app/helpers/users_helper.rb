module UsersHelper
	def handle_if_approved(user)
    if user.is_approved?
      "[drag]"
    else
      ""
    end
  end

  
end