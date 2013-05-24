jQuery ->
	$("body").delegate ".close_form", "click", ->
		$("#lightbox").remove()