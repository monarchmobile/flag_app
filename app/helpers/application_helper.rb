module ApplicationHelper

	# gets width height left and top for images in scrapbook
	def get_dimensions(id, range)
	    @user = current_user
	    image = @user.images.find(id)
	    time_frame = range+'_dim'
	    dim_params = image.send(time_frame)
	    # get width and height dimensions 

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
		@user = current_user
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

	def bread_crumb_beg(bread_crumb)
		@bread_crumb_beg = bread_crumb
	end
	def bread_crumb_end(bread_crumb)
		page = request.path.split('/')[1]
		if (page == "weekly_scrapbook") 
			@bread_crumb_end = bread_crumb
		elsif (page == "monthly_scrapbook")  
			@bread_crumb_end = bread_crumb.to_date+6.days; 
		elsif (page == "yearly_scrapbook")  
			@bread_crumb_end = bread_crumb.to_date.end_of_month; 
		end
		@bread_crumb_end
	end

	def week_calculations
	 @beg_range = @beg_range.to_date 
	 @end_range = @end_range.to_date 
	 @first_of_month = @beg_range.to_date.beginning_of_month 
	 @last_of_month = @beg_range.to_date.beginning_of_month.next_month-1 

		 if (@end_range+7).between?(@first_of_month, @last_of_month) 
			 if @beg_range.between?(@beg_range.prev_month.end_of_month, @beg_range.beginning_of_month+1) 
				# <!--1st Week-->
				 @beg_of_prev_week = @beg_range.prev_month.beginning_of_month + 4.weeks 
				 @end_of_prev_week = @end_range.prev_month.end_of_month 
				
				 @beg_of_next_week = @beg_range+7.days 
				 @end_of_next_week = @end_range+7.days 
			 else 
				# <!--Middle Weeks-->
				 @beg_of_prev_week = @beg_range-7.days 
				 @end_of_prev_week = @end_range-7.days 
				
				 @beg_of_next_week = @beg_range+7.days 
				 @end_of_next_week = @end_range+7.days 
			 end 
		 elsif 
			 if @beg_range.next_week.beginning_of_week.between?(@first_of_month, @last_of_month) 
				# <!--4th Week-->
				 @beg_of_prev_week = @beg_range-7.days 
				 @end_of_prev_week = @end_range-7.days 
				
				 @beg_of_next_week = @beg_range+7.days 
				 @end_of_next_week = @end_range.end_of_month 	
			 else 
				# <!--5th Week-->
				 @beg_of_prev_week = @beg_range-7.days 
				 @end_of_prev_week = @end_range-2.days 
				
				 @beg_of_next_week = @beg_range.next_month.beginning_of_month 
				 @end_of_next_week = @end_range.next_week.beginning_of_month+6.days 
			 end 
		 end 
	end

	def range_calculations
		 @beg_range = @beg_range.to_date 
		 @end_range = @end_range.to_date 
	 
		 @page = request.path.split('/')[1] 
		 num = (@beg_range.strftime("%d").to_i-1)/7 
		 @beg_range_week = @beg_range.beginning_of_month+num.weeks 
		 @end_range_week = @beg_range.beginning_of_month+num.weeks+6.days 
	end

	def get_range
		page = request.path.split("_")[0][1..-1]
		if page == "daily"
			@range = "day"
		elsif page == "weekly"
			@range = "week"
		elsif page == "montly"
			@range = "month"
		elsif page == "yearly"
			@range = "year"
		end
	end

	def crop_bread_crumb
		 parameters = request.url.split("?")[1].split("&") 
		 bread_crumb_beg = parameters[0].split("=")[1][3..-4]
		 range = parameters[1].split("=")[1]
		 if range == "day"
		 	path ="daily_scrapbook"
		 	values = "?beg_range="+bread_crumb_beg+"&end_range="+bread_crumb_beg
		 elsif range =="week"
		 	path = "weekly_scrapbook"
		 	values = "?beg_range="+bread_crumb_beg+"&end_range="+bread_crumb_beg
		 elsif range =="month"
		 	path = "monthly_scrapbook"
		 elsif range == "year"
		 	path = "yearly_scrapbook"
		 end

		 root_url+path+values 
	end

	def link_to_profile_if_logged_in_else_community
		if current_user 
           link_to content_tag(:li, "Profile"), user_path(current_user.id) 
        else 
           link_to content_tag(:li, "Community"), users_path 
        end 
	end

	def editable_if_current_user(user, field)
		if current_user?(user) 
			best_in_place user, field.to_sym
		else

			"#{user.send(field)}"
		end
	end
end
