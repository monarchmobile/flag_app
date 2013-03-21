jQuery ->
	$("select").change ->
		$(this).closest("form").submit()