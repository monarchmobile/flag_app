# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

	$('.auth-form').hide()
	$('.image_form').hide

	$(".images_container li").hover (->
	  $(this).addClass "current"
	  $(".current .scrap_image_X").show()
	), ->
	  $(".current .scrap_image_X").hide()
	  $(this).removeClass "current"

	$(".drop-auth").toggle (->
  		$(".auth-form").show()
  	), (->
  		$(".auth-form").hide()
  	)

  $(".drop-image").toggle (->
    $(".image_form").show()
  ), ->
    $(".image_form").hide()

  	$(".auth-form input, .auth-form label").click (e) ->
  		e.stopPropagation()



 