CalculateDate = 
	init: (start_date, end_date, clicked) ->
		start_date = @cleanDate(start_date)
		end_date = @cleanDate(end_date)
		this.clicked = clicked
		@prepDate(start_date, end_date)

	cleanDate: (date) -> 
		date_array = date.split("-")
		new_date = date_array[1]+"/"+date_array[0]+"/"+date_array[2]

	resetCurrentState: (status, num) ->
		$("input[type=submit]").val(status)
		$("#page_current_state option").attr("selected", false)
		$("#page_current_state option[value="+num+"]").attr("selected", "selected")

	compareDates: ->
		if this.start_val > this.end_val
			console.log "crossed"
			$("input#page_"+this.clicked+"s_at").parent().append("<div class='message'></div>")
			$(".message").html("'Starts at' date is greater than the 'Ends at' date")

	startWasClicked: ->
		@compareDates()
		if this.start_val <= this.today
				@resetCurrentState("Publish", 3)
		else if this.start_val > this.today
				@resetCurrentState("Schedule", 2)

	endWasClicked: ->
		@compareDates()
		if this.end_val < this.today
			$("input#page_"+this.clicked+"s_at").parent().append("<div class='message'></div>")
			$(".message").html("You must choose an "+this.clicked+" date that is after today")
			$("input#page_"+this.clicked+"s_at").val("")
		else if this.end_val >= this.today
			if this.start_val < this.today
				@resetCurrentState("Publish", 3)
			else if this.start_val >= this.today
				@resetCurrentState("Schedule", 2)

	prepDate: (start_date, end_date) ->
		this.start_val = new Date(start_date).valueOf()
		this.end_val = new Date(end_date).valueOf()
		this.today = new Date()
		$(".message").remove()
		if this.clicked == "start"
			@startWasClicked()
		else if this.clicked == "end"
			@endWasClicked()

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

	    