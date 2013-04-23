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
	), 1000

	# content box on profile page
	$(".img_feed_container").hover (->
	  $(this).css "z-index", "100" 
	  $(this).find(".img_content_container").show()
	), ->
	  $(this).css "z-index", "0"
	  $(this).find(".img_content_container").hide()
# profile image on onhover
	$(".profile_image").hover (->
		$(this).parent().next(".member_info").show()
	), ->
		$(this).parent().next(".member_info").hide()


	# user approval status
	$("body").delegate ".user_ajax_edit .user_approval_status", "change", ->
		select = $(this).prev()
		if select.val() == "true"
			select.val("false")
			console.log(select.val())
			select.closest("form").submit()
			$(this).html("Not Approved").removeClass("green_background").addClass("red_background")
		else if select.val() == "false"
			select.val("true")
			select.closest("form").submit()
			$(this).html("Approved").addClass("green_background").removeClass("red_background")

	# user approval status
	$("body").delegate ".user_ajax_edit .user_approval_status", "click", ->
		select = $(this).prev()
		if select.val() == "true"
			select.val("false")
			console.log(select.val())
			select.closest("form").submit()
			$(this).html("Not Approved").removeClass("green_background").addClass("red_background")
		else if select.val() == "false"
			select.val("true")
			select.closest("form").submit()
			$(this).html("Approved").addClass("green_background").removeClass("red_background")

	$('.best_in_place').best_in_place()



	
