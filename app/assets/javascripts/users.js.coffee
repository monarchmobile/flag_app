# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$(".flag_feed ul li:nth-child(3n+1)").addClass "first"
	$(".flag_feed ul li:nth-child(3n+2)").addClass "second"
	$(".flag_feed ul li:nth-child(3n+3)").addClass "third"
	setTimeout (->
	  image = []
	  i = 1
	  while i <= 11
	    x = i + 3
	    image[i] = $(".img_feed_container[data-counter = '" + i + "']").height()
	    if i > 0 and i < 4
	      $(".img_feed_container[data-counter = '" + x + "']").css "margin-top", image[i] + 50 + "px"
	    else $(".img_feed_container[data-counter = '" + x + "']").css "margin-top", image[i] + image[i - 3] + 95 + "px"  if i > 3 and i < 7
	    i++

	# $(".message_board").append("<li>image"+x+" is "+image[i]+"px</li>")
	), 500

	# content box on profile page
	$(".img_feed_container").hover (->
	  $(this).css "z-index", "100"
	  $(this).find(".img_content_container").show()
	), ->
	  $(this).css "z-index", "0"
	  $(this).find(".img_content_container").hide()

	
