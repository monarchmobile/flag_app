# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#image_date_taken').datepicker
		dateFormat: 'yy-mm-dd'

	$(".edit_image input[type=checkbox]").click ->
  		$(this).parent("form").submit()

  	
 			


  		

	
