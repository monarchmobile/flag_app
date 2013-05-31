CalculateDate = 
	init: (start_date, end_date, clicked) ->
		start_date = @cleanDate(start_date)
		end_date = @cleanDate(end_date)
		this.clicked = clicked
		@compareDate(start_date, end_date)

	cleanDate: (date) -> 
		date_array = date.split("-")
		new_date = date_array[1]+"/"+date_array[0]+"/"+date_array[2]
		
	compareDate: (start_date, end_date) ->
		self = this
		start_val = new Date(start_date).valueOf()
		end_val = new Date(end_date).valueOf()
		today = new Date()
		$(".message").remove()
		if start_val != null && end_val is null
			if start_val <= today
					$("input[type=submit]").val("Publish")
					$("#page_current_state").val("3")
			else if start_val > today
					$("input[type=submit]").val("Schedule")
					$("#page_current_state").val("2")
		if start_val != null && end_val != null
			if start_val < end_val
				if start_val <= today && end_val > today
					$("input[type=submit]").val("Publish")
				else if start_val > today && end_val > today
					$("input[type=submit]").val("Schedule")
				else if start_val < today && end_val < today
					$("input#page_"+self.clicked+"s_at").parent().append("<div class='message'></div>")
					$(".message").html("You must choose an "+self.clicked+" date that is after today")
					$("input#page_"+self.clicked+"s_at").val("")
			else if start_val > end_val
				$("input#page_"+self.clicked+"s_at").parent().append("<div class='message'></div>")
				$(".message").html("Starts at Date is greater than the Ends at Date")
				$("input#page_"+self.clicked+"s_at").val("")

jQuery ->
	# pages/index
	if $('body.pages_index').length > 0
		#select current_state
	  $("body").delegate ".page_ajax_edit select", "change", ->
	    $(this).closest("form").unbind('submit').submit()

	  # sort pages
	  $("#published_pages").sortable
	    axis: "y"
	    handle: ".handle"
	    update: ->
	      $.post $(this).data("update-url"), $(this).sortable("serialize")

	  # page links
	  $("body").delegate ".page_ajax_edit .page_link_location", "click", ->
		  checkbox = $(this).prev()
		  attr_checked = checkbox.attr("checked")
		  console.log(attr_checked)
		  if attr_checked && attr_checked == "checked"
		    checkbox.removeAttr "checked"
		    checkbox.closest("form").submit()
		  else
		    checkbox.attr "checked", "checked"
		    checkbox.closest("form").submit()

	# pages/edit || pages/new
	if $('body.pages_edit').length > 0 || $('body.pages_new').length > 0
		# hide schedule container if current state is draft on page load
		$(".schedule_container").hide() if $("select#page_current_state option").first().attr("selected") == "selected"

		# select current_state
		$("body").delegate "select#page_current_state", "change", ->
			if $(this).val() == "1"
				$("input[type=submit]").val("Save Draft")
				$(".schedule_container").hide()
			if $(this).val() == "2"
				$("input[type=submit]").val("Schedule For")
				$(".schedule_container").show()
			else if $(this).val() == "3"
				$("input[type=submit]").val("Publish Now")
				$(".schedule_container").hide()

		# date format
		$("#page_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#page_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#page_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#page_ends_at").val()
			CalculateDate.init(start_date, end_date, "start")

		$("body").delegate "#page_starts_at", "click", ->
			start_date = $(this).val()
			end_date = $("#page_ends_at").val()
			CalculateDate.init(start_date, end_date, "start")

		$("body").delegate "#page_ends_at", "change", ->
			start_date = $("#page_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end")

		$("body").delegate "#page_ends_at", "click", ->
			start_date = $("#page_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end")
			
			# console.log()

	$("body").delegate ".close_form", "click", ->
			console.log("clicked")
			$(this).parent().hide()

	    