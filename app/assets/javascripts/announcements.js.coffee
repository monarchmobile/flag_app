# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$("#announcement_starts_at").datepicker
	        dateFormat: 'yy-mm-dd'
	$("#announcement_ends_at").datepicker
	        dateFormat: 'yy-mm-dd'
