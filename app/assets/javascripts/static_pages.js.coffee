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

  ### Days of the month ###
  day_container = $(".day_container")
  days_of_month = $(".days_of_month")
  day_container.hide()
  days_of_month.on "click", ->
    $(this).parent().prev('form').submit()
    $(".test3").html ""
    $('.days_of_month').css("font-size" , "12px")
    $(this).css("font-size" , "20px")

  $('.month-of-year').hide()
  $('.current_month').show()

  ### Weeks of Month ###
  
  weeks_of_month = $('.weeks_of_month')
  weeks_of_month.on "click", ->
    $(this).parent().prev('form').submit()

  ### Months of the Year ###
  month_container = $('.month_container')
  months_of_year = $(".months_of_year")
  month_container.hide()
  months_of_year.on "click", ->
    month_container.hide()
    $(this).parent().prev('form').submit()
    #month = $(this).data("month")
    $('#'+month).show()
    $('.test3').html month

  ### Months - Prev and Next buttons ###
  



 
  
  



 