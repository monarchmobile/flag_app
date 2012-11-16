# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

	$(".photos_container li").click (->
    alert('works')
	  $(this).addClass "current"
	  $(".current .actions").show()
	), ->
	  $(".current .actions").hide()
	  $(this).removeClass "current"
  ### Abve - Single image container, actions show onhover ###

  $('.edit_image input[type=checkbox]').click ->
    $(this).parent('form').submit()
    $(this).parent('form').hide().append('<div class="gallery_msg">Successfully done!!</div>')

  ############## --- FORMS --- ################
  ### Sign in - Form drops down ###
	$(".drop-auth").toggle (->
  		$(".auth-form").show()
  	), (->
  		$(".auth-form").hide()
  	)
 
  ### Image - Form drops down ###
  $(".drop-image").toggle (->
    $(".image_form").show()
  ), ->
    $(".image_form").hide()

  ### Journal - Form drops down ###
  $(".drop-journal").toggle (->
    $(".journal_form").show()
  ), ->
    $(".journal_form").hide()
  
  ### Fix bug - When clicking on any area of form, form was dis ###
  $(" .auth-form input, 
      .auth-form label,
      .image_form input,
      .image_form label,
      .journal_form input,
      .journal_form label
      ").click (e) ->
  		e.stopPropagation()
  ############## --- End FORMS --- ###############

  $(".image_container").click ->

    $(this).animate
      width: "500px",
      height: "300px"
    , "slow"
    



  
  
  



 
  
  



 