module ApplicationHelper  
	# if user has a profile pic, this is displayed, otherwise an "empty image" is displayed
	def if_requireds_are_blank?(user)
		user.first_name && user.last_name && user.city
	end

	def object_status(object)
		status_id = object.status_ids.first.to_i
		@status = Status.find(status_id)
		@status.current_state
	end

	def profile_pic_if_uploaded(user) 
		if user.member_photo
			user.member_photo_url
		end
	end

	def andrew(text)
		content_tag(:div, "For Andrew:#{text}", class: "super_admin andrew") if current_user.role? :Admin
	end

	def rod(text)
		content_tag(:div, "For Rod:#{text}", class: "super_admin rod") if current_user.role? :Admin
	end

	def correct_level(range) 
		page
		if page == range
			"on_#{range}_frame"
		else
			"off_frame"
		end
	end

	def remove_from_db(user)
	    user.destroy
	end

	# ** USER TYPES ** 
	def admin?(user)
		user.user_type == 1
	end

	def student?(user)
		user.user_type == 2
	end

	# highlights gallery that current_user has voted on 
	def chosen(already, owner, other)
		if already && already.owner_id == owner.id && current_user
			"chosen"
		else
			other
		end
	end

	def total_vote(owner, type, beg_range)
		@week_total = Vote.find(:all, conditions: { owner_id: owner.id, range_type: type, beg_range: beg_range }).count
	end 

	
	

	def hello
		"hello"
	end

	def notice
		"<p id='notice'><%= notice %></p>"
	end
	
	# members_page and member is not a guest
	def members_page(user)
		current_user?(user) && !current_user.guest?
	end

	# registered_member
	def registered_member
		current_user && !current_user.guest?
	end

	# found in users/create: used as a redirect after guest login 
	def correct_page(page_to_render)
		"/#{page_to_render}"
	end

	# page request by user with click
	def page_requested
		request.env['REQUEST_PATH'].split("/")[-1]
	end

	# generates red stars for required fields in any form
	def required_field
		content_tag :span, "**", class: "required_field"
	end

	def correct_root	
		correct_root = "http://localhost:3000"
	end

	def current_params
		"beg_range=#{@beg_range}%26end_range=#{@end_range}"
	end
 
	def current_path(user)
		"#{root_path}users/#{user.id}/scrapbook/#{page}%3F"

	end

	def return_to_previous_page(user)
		past_page = @bread_crumb.split("/")[-1].split("?")[0]
		page
		frames
		num = 0
		while num < frames.length
			url = "#{root_url}users/#{user.id}/scrapbook/#{frames[num-1]}"
			if (page == frames[num] && past_page == frames[num]) ||  (page == frames[num] && past_page == frames[num+1])# going sideways
				if frames[num] == "week"
					new_beg_range = @beg_range
					new_end_range = @beg_range
				elsif frames[num] == "month"
					new_beg_range = @beg_range
					new_end_range = @beg_range+6.days
				elsif frames[num] == "year"
					new_beg_range = @beg_range
					new_end_range = @beg_range.end_of_month
				end
				new_url = "#{url}?beg_range=#{new_beg_range}&end_range=#{new_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
			elsif page == frames[num] && past_page == frames[num-1] # going up
				new_url = "#{@bread_crumb}&bread_crumb=#{current_path(user)}#{current_params}"
			end
			num+=1
		end
		new_url
	end

	def description?(image)
		image.content.length > 0
	end

	# gets width height left and top for images in scrapbook
	def get_dimensions(id, range)
	  
	    image = @user.images.find(id)
	    time_frame = range+'_dim'
	    dim_params = image.send(time_frame)
	    time_frame2 = range+'_z'
	    z_params = image.send(time_frame2)
	    # get width and height dimensions 
	    @z_index = z_params

	    if dim_params
	        @con_width = dim_params.split(",")[0].to_i  
	        @con_height = dim_params.split(",")[1].to_i 
	        @width = dim_params.split(",")[0].to_i  
	        @height = dim_params.split(",")[1].to_i   
	    else
	    	@con_width = ""  
	        @con_height = "" 
	        @width = ""  
	        @height = ""
	    end
	end

	# get left and top positions 
	def get_positions(id, range)
	
	    image = @user.images.find(id)
	    time_frame = range+"_p"
	    pos_params = image.send(time_frame)

		if pos_params
			@left = pos_params.split(",")[0].to_i 
			@top = pos_params.split(",")[1].to_i 
		else
			@left = ""
			@top = ""
		end
		
	end

	# if user logged in menu bar will show profile, otherwise, Community
	def link_to_profile_if_logged_in_else_community
		if current_user && !current_user.guest?
           link_to content_tag(:li, current_user.fullname), user_path(current_user.id) 
        else 
           link_to content_tag(:li, "Community"), users_path 
        end 
	end

	# allows current_user to edit his own profile page.  Fields become editable if owner
	def editable_if_current_user(user, field)
		if current_user?(user) 
			best_in_place user, field.to_sym
		else

			"#{user.send(field)}"
		end
	end 

	# *** START -- up down previous and next links -- START *** 
	# setting up variables
		# determine current page
	def page
		page = request.path.split("/")[-1]
	end

	# setting up variable at the beginning of image array for each time period
	def page_variables(image)
		if page == frames[0] || page == frames[1]
			 num = image.date_taken.strftime("%d").to_i/7 
			 @beg_week = image.date_taken.beginning_of_month+num.weeks 
			 @end_week = @beg_week+6.days 
		elsif page == frames[2]
			 @beg_year = image.date_taken.beginning_of_year 
			 @end_year = image.date_taken.end_of_year 
			 beg_month = image.date_taken.beginning_of_month.strftime("%Y-%m-%d") 	 
		end
		get_dimensions(image.id, page)  
		get_positions(image.id, page) 
	end
		# set array of pages
	def frames
		frames = ["day", "week", "month", "year"]
	end

	# :"data-range" => get_range(@user) on journal_script.html.erb
	def unless_already_on_scrapbook_page
		if request.path.split("/")[3] == "scrapbook"
			""
		else
			"Scrapbook"
		end
	end

	def go_to_scrapbook 
		root_path+"users/"+current_user.id.to_s+"/scrapbook/day"
	end
	# dynamic uplink

	def go_to_text(direction)
		page
		frames
		num = 0
		while num < frames.length 
			if page == frames[num]
				if direction == "up" 
					if num == 3
					 	# @destination = frames[num-3] gets you back to day
					 	@go_to = ""
					else
						@go_to = "Go to "+frames[num+1] 
					end
				elsif direction == "down"
					if num == 0
					 	# @destination = frames[num-3] gets you back to day
					 	@go_to = ""
					else
						@go_to = "Go to "+frames[num-1] 
					end
				end
			end 
			num += 1 
		end
		@go_to
	end



	def go_to_up_link(user)
		page
		frames
		num = 0
		while num < frames.length 
			if page == frames[num] 
				if num == 3
				 	# @destination = frames[num-3] gets you back to day
				 	@destination = ""
				else
					@destination = frames[num+1] 
				end
			end 
			num += 1 
		end
		@base_path = root_path+"users/#{user.id}/scrapbook/#{@destination}"
	end

	# dynamic downlink
	def go_to_down_link(user)
		# page
		# frames
		# num = 0
		# while num < 4 
		# 	if page == frames[num] 
		# 		if num == 0
		# 			@destination = frames[num+3]
		# 		else
		# 			@destination = frames[num-1] 
		# 		end
		# 	end 
		# 	num += 1 
		# end
		# @base_path = root_path+"users/#{user.id}/scrapbook/#{@destination}"
		@bread_crumb.split("?")[0]
	end

	# dynamic specific day, previous, or next link
	def go_to_date_link(user)
		dynamic_range
		@base_path = root_path+"users/#{user.id}/scrapbook/#{@destination}"
	end

	# dynamically tells you what page range you are on %w[day week month year]
	def dynamic_range 
		page
		frames
		num = 0
		while num < 4 
			if page == frames[num] 
				@destination = frames[num] 
			end 
			num += 1 
		end
	end

	# static specific day
	def go_to_range(user, num)
		page
		frames
		@destination = frames[num] 
		@base_path = root_path+"users/#{user.id}/scrapbook/#{@destination}"
	end

	def duration_params(date_taken, user, duration)
		@date_taken = date_taken
		if duration == "day"
			@new_beg_range = @date_taken 
			@new_end_range = @date_taken
		elsif duration == "week"
			num = date_taken.strftime("%d").to_i 
			num = (num-1)/7 
			@new_beg_range = @date_taken.beginning_of_month+num.weeks 
			@new_end_range = @date_taken.beginning_of_month+num.weeks+6.days 
		elsif duration == "month"
			@new_beg_range = @date_taken.beginning_of_month 
			@new_end_range = @date_taken.end_of_month
		end
		"?beg_range=#{@new_beg_range}&end_range=#{@new_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	# *** END -- up down previous and next links -- END ***

	# *** START -- up down previous and next link parameters -- START ***
	# Determine which page user is on (ie. day, week, month ,year)

	# set beg and end range
	def declare_beg_range
		@beg_range = @beg_range.to_date 
		@end_range = @end_range.to_date 
	end

	# up link parameters
	def up_link_params(user,range)
		declare_beg_range
	 	if range == frames[0]
			@new_beg_range = @beg_range 
			@new_end_range = @beg_range
		elsif range == frames[1]
			num = (@beg_range.strftime("%d").to_i-1)/7 
			@new_beg_range = @beg_range.beginning_of_month+num.weeks 
			@new_end_range = @beg_range.beginning_of_month+num.weeks+6.days
		elsif range == frames[2]
			@new_beg_range = @beg_range.beginning_of_month 
		 	@new_end_range = @beg_range.beginning_of_month.end_of_month
		elsif range == frames[3]
			@new_beg_range = @beg_range.beginning_of_year
		 	@new_end_range = @beg_range.end_of_year
		end
		"?beg_range=#{@new_beg_range}&end_range=#{@new_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def determine_week(date)
		@num = (date.strftime("%d").to_i-1)/7
	end

	# down link parameters
	def down_link_params(user)
		declare_beg_range
		if page == frames[1]
			determine_week(@beg_range)
			 
			@new_beg_range = @beg_range.beginning_of_month+@num.weeks
			@new_end_range = @beg_range.beginning_of_month+@num.weeks
		elsif page == frames[2]
			@new_beg_range = @beg_range.beginning_of_month 
		 	@new_end_range = @beg_range.beginning_of_month+6.days
		elsif page == frames[3]
			@new_beg_range = @beg_range.beginning_of_year
		 	@new_end_range = @beg_range.next_month-1
		end
		"?#{@bread_crumb.split("?")[1]}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	# previous link parameters
	def prev_link_params(user)
		determine_page_time_frame
		@bread_crumb = @beg_range
		"?beg_range=#{@prev_beg_range}&end_range=#{@prev_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def prev_next_link_text(dir, user)
		declare_beg_range
		determine_page_time_frame
		if dir == "prev"
			if page == frames[0]
				@prev_beg_range.strftime("%d")
			elsif page == frames[1]
				determine_week(@beg_range)
				"#{@prev_beg_range.strftime("%d")}-#{@prev_end_range.strftime("%d")}"
			elsif page == frames[2]
				@prev_beg_range.strftime("%b")
			elsif page == frames[3]
				@prev_beg_range.strftime("%Y")
			end
		elsif dir == "next"
			if page == frames[0]
				@next_beg_range.strftime("%d")
			elsif page == frames[1]
				determine_week(@end_range)
				"#{@next_beg_range.strftime("%d")}-#{@next_end_range.strftime("%d")}"
			elsif page == frames[2]
				@next_beg_range.strftime("%b")
			elsif page == frames[3]
				@next_beg_range.strftime("%Y")
			end
		end
	end



	# next link parameters
	def next_link_params(user)
		determine_page_time_frame
		@bread_crumb = @beg_range
		"?beg_range=#{@next_beg_range}&end_range=#{@next_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def date_range_params(day,user)
		"?beg_range=#{day}&end_range=#{day}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def previous_week_beg(today)
	   day_date = today.strftime("%Y-%m-%d").split("-")[2]
	   num = day_date.to_i
	   @num = (num/7)-1.01
	   @first_of_month = today.to_date.beginning_of_month
	   @new_beg_range = @first_of_month.to_date+@num.weeks
	    
	   
	end

	def previous_week_end(today)
		previous_week_beg(today)
		if @num == 4 
	         @new_end_range = @first_of_month.to_date.next_month-1 
	    else 
	         @new_end_range = @first_of_month.to_date+(@num+1).weeks-1 
	    end

	end

	def determine_week_params(date_taken,user)
	   day_date = date_taken.split("-")[2]
	   num = (day_date.to_i)
	   num = ((num-1)/7)
	   @first_of_month = date_taken.to_date.beginning_of_month
	   weeks_of_month_params(num,user)
	end

	def last_month_contest_params(date_taken, user)
		@new_beg_range = date_taken.beginning_of_month
		@new_end_range = date_taken.end_of_month
		"?beg_range=#{@new_beg_range}&end_range=#{@new_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def weeks_of_month_params(num,user) 
		@new_beg_range = @first_of_month.to_date+num.weeks 
		if num == 4 
	         @new_end_range = @first_of_month.to_date.next_month-1 
	    else 
	         @new_end_range = @first_of_month.to_date+(num+1).weeks-1 
	    end  
		"?beg_range=#{@new_beg_range}&end_range=#{@new_end_range}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def months_of_year_params(num,user) 
		@join_date = user.created_at 
		@beg_month = (@join_date.to_date >> num).beginning_of_month 
		@end_month = (@join_date.to_date >> num).end_of_month 
		"?beg_range=#{@beg_month}&end_range=#{@end_month}&bread_crumb=#{current_path(user)}#{current_params}"
	end

	def determine_page_time_frame
		if page == frames[0]
			day_calculations
		elsif page == frames[1]
			week_calculations
		elsif page == frames[2]
			month_calculations
		elsif page == frames[3]
			year_calculations
		end
	end

	# to navigate to previous and next days on day page
	def day_calculations
		@prev_beg_range = @beg_range.to_date-1.day
		@prev_end_range = @beg_range.to_date-1.day
		@next_beg_range = @beg_range.to_date+1.day
		@next_end_range = @beg_range.to_date+1.day
	end

	# to navigate to previous and next weeks on week page

	def week_calculations
		@first_of_month = @beg_range.to_date.beginning_of_month 
		@last_of_month = @beg_range.to_date.beginning_of_month.next_month-1 
		if (@end_range+7).between?(@first_of_month, @last_of_month) 
			if @beg_range.between?(@beg_range.prev_month.end_of_month, @beg_range.beginning_of_month+1) 
				# <!--1st Week-->
				 @prev_beg_range = @beg_range.prev_month.beginning_of_month + 4.weeks 
				 @prev_end_range = @end_range.prev_month.end_of_month 
				
				 @next_beg_range = @beg_range+7.days 
				 @next_end_range = @end_range+7.days 
			else 
				# <!--Middle Weeks-->
				 @prev_beg_range = @beg_range-7.days 
				 @prev_end_range = @end_range-7.days 
				
				 @next_beg_range = @beg_range+7.days 
				 @next_end_range = @end_range+7.days 
			end 
		elsif 
			if @beg_range.next_week.beginning_of_week.between?(@first_of_month, @last_of_month) 
				# <!--4th Week-->
				 @prev_beg_range = @beg_range-7.days 
				 @prev_end_range = @end_range-7.days 
				
				 @next_beg_range = @beg_range+7.days 
				 @next_end_range = @end_range.end_of_month 		
			else 
				# <!--5th Week-->
				 @prev_beg_range = @beg_range-7.days 
				 @prev_end_range = @end_range-2.days 
				
				 @next_beg_range = @beg_range.next_month.beginning_of_month 
				 @next_end_range = @end_range.next_week.beginning_of_month+6.days 
			end 
		end 
	end

	# to navigate to previous and next months on month page
	def month_calculations
		@prev_beg_range = @beg_range.to_date.beginning_of_month.prev_month
		@prev_end_range = @beg_range.to_date.beginning_of_month-1.day
		@next_beg_range = @beg_range.to_date.next_month.beginning_of_month
		@next_end_range = @beg_range.to_date.next_month.end_of_month
	end

	# to navigate to previous and next years on year page
	def year_calculations
		@prev_beg_range = @beg_range.to_date.beginning_of_year.prev_year
		@prev_end_range = @beg_range.to_date.beginning_of_year-1.day
		@next_beg_range = @beg_range.to_date.next_year.beginning_of_year
		@next_end_range = @beg_range.to_date.next_year.end_of_year
	end
	# *** END -- up down previous and next link parameters -- END ***

	# START -- image container -- START
	def up_gallery_has_room
		if page == frames[0]
			num = image.date_taken.strftime("%d").to_i/7 
			@up_gallery_beg_range = image.date_taken.beginning_of_month+num.weeks 
			@up_gallery_end_range = @up_gallery_beg_range+6.days 
		end
		(date_taken=(up_gallery_beg_range..@up_gallery_end_range)&page=true).count < 5
	end

	# supermodel grab all model names in database
	def update_list
    models = ActiveRecord::Base.connection.tables.collect{|t| t.underscore.singularize.camelize}
    models.each do |m|
      if Supermodel.find(:all, conditions: {name: m}).count == 0
        Supermodel.create(name: m, visible: false)
      end
    end
    client_models = ["Role", "Page", "Announcement", "Event", "Partial", "User"]
    client_models.each do |cm|
      instance = Supermodel.find_by_name(cm)
      instance.update_attributes(visible: true)
    end
  end

  # user index
  def handle_if_approved(user)
    if user.is_approved?
      "[drag]"
    else
      ""
    end
  end

  # pages index
  def handle_if_published(page)
    if page.is_published?
      "[drag]"
    else
      ""
    end
  end

  def position_if_published(page)
    if page.is_published?
      page.position
    else
      ""
    end
  end

  def green_if_checked(page, link_id)
    if page.link_ids.include?(link_id)
      "green_background"
    else
      "red_background"
    end
  end

  def role_id(role)
    role = role.to_s.camelize
    Role.find_by_name(role).id
  end

  def green_if_role(user, role_id)
    if user.role_ids.include?(role_id)
      "green_background"
    else
      "red_background"
    end
  end

  def check_if_draft(announcement)
    current_state = announcement.current_state
    draft = Status.find_by_status_name("draft").id
    if current_state == draft
      "hidden"
    end
  end

  # user index
  def user_approved_status(user)
    if user.approved == true
      "Approved"
    elsif user.approved == false
      "Not Approved"
    end
  end

  def green_if_approved(user)
    if user.approved == true
      "green_background"
    else
      "red_background"
    end
  end

  def user_approved(user)
  	user.approved == true
  end

  def show_area_if_area(user)
  		user.regional_coor unless user.regional_coor.blank?
  end

  def reset_current_state(model)
  	scheduled = Status.find_by_status_name("scheduled").id
		published = Status.find_by_status_name("published").id
		draft = Status.find_by_status_name("draft").id
		anns = Describe.new(model).partial
		anns.each do |a|
			if !a.starts_at.blank? && a.starts_at <= Date.today
				a.update_attributes(current_state: published)
			elsif !a.starts_at.blank? && a.starts_at > Date.today
				a.update_attributes(current_state: scheduled)
			end
			
			if !a.ends_at.blank? && a.ends_at <= Date.today-1
				a.update_attributes(current_state: draft)
			end

			if a.starts_at.blank?
				a.update_attributes(current_state: draft)
			end
		end
  end

  def announcement_mailer
  	published = Status.find_by_status_name("published").id
  	announcements = Announcement.all
  	announcements.each do |a|
  		if !a.starts_at.blank? && a.starts_at <= Date.today
  			a.send_announcement_email
  		end
  	end
  end

  def publish_page_if_in_range
  	scheduled = Status.find_by_status_name("scheduled").id
		published = Status.find_by_status_name("published").id
		draft = Status.find_by_status_name("draft").id
		pages = Page.all
		pages.each do |a|
			if !a.starts_at.blank? && a.starts_at <= Date.today
				count = (Describe.new(Page).published.count)
				a.update_attributes(current_state: published, position: count+1)
			elsif !a.starts_at.blank? && a.starts_at > Date.today
				a.update_attributes(current_state: scheduled)
			end
			
			if !a.ends_at.blank? && a.ends_at <= Date.today-1
				a.update_attributes(current_state: draft)
			end

			if a.starts_at.blank?
				a.update_attributes(current_state: draft)
			end
		end
  end

  
end
