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


	$("body").delegate ".close_form", "click", ->
			console.log("clicked")
			$(this).parent().hide()

	    