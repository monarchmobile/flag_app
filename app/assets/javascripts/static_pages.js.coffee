# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

	$(".images_container li").hover (->
	  $(this).addClass "current"
	  $(".current .actions").show()
	), ->
	  $(".current .actions").hide()
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

  $(" .auth-form input, 
      .auth-form label,
      .image_form input,
      .image_form label,
      .journal_form input,
      .journal_form label
      ").click (e) ->
  		e.stopPropagation()

  $(".drop-journal").toggle (->
    $(".journal_form").show()
  ), ->
    $(".journal_form").hide()

  day_container = $(".day_container")
  days_of_month = $(".days_of_month")

  day_container.hide();
  days_of_month.on "click", ->
    
    $(".test3").html ""
    $('.days_of_month').css("font-size" , "12px")
    exists = $(this).data("exists")
    if exists is "no"
      $(".outside_add").show()
      $(".test3").html exists
    else 
      $(".outside_add").hide()
      $(".test3").html exists if exists is "yes"

    day_container.hide();
    dom_btn = $(this).data("date")
    $("#" + dom_btn).show()
    $(this).css("font-size" , "20px")

    $('.test1').html "current_day: "+dom_btn

  $('.month-of-year').hide()
  $('.current_month').show()

  $('.prev').click ->
    which_month = $(this).parent().parent().next().attr('id')
    $('.test1').html "current_month: "+which_month 

    $('.month-of-year').removeClass "current_month" 
    $(this).parent().parent().next().addClass "current_month" 
    $('.month-of-year').hide()
    $('.current_month').show();

  $('.next').click ->
    which_month = $(this).parent().parent().prev().attr('id')
    $('.test1').html "current_month: "+which_month

    $('.month-of-year').removeClass "current_month"                             
    $(this).parent().parent().prev().addClass "current_month" 
    $('.month-of-year').hide()
    $('.current_month').show();



 