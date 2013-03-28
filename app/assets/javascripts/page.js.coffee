jQuery ->
	$(".edit_page select").change ->
		$(this).closest("form").submit()