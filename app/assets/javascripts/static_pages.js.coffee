# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#journal_form").addClass("hide")
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
  $(".drop-journal").click ->
  if $(this).next().next().is(":visible")
    $(this).next().next().hide()
  else
    $(this).next().next().show()

  
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

  $.fn.center = ->
    @css
      position: "fixed"
      left: "50%"
      top: "50%"
    @css
      "margin-left": -@width() / 2 + "px"
      "margin-top": -@height() / 2 + "px"
    this







  
  
  



 
  
  



 