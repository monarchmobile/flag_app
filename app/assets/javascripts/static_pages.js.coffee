# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  $("#journal_form").addClass("hide")

  ### Fix bug - When clicking on any area of form, form was dis ###
  # $(" .auth-form input, 
  #     .auth-form label,
  #     .image_form input,
  #     .image_form label,
  #     .journal_form input,
  #     .journal_form label
  #     ").click (e) ->
  # 		e.stopPropagation()
  # ############## --- End FORMS --- ###############

  $.fn.center = ->
    @css
      position: "fixed"
      left: "50%"
      top: "50%"
    @css
      "margin-left": -@width() / 2 + "px"
      "margin-top": -@height() / 2 + "px"
    this

   # background_fadeIn = $("#background").css(opacity: "0.7")
   # background_fadeOut = $("#background")

   # $(".sign_up_btn").toggle (->
   #    URL = "/users/new"
   #    background_fadeIn.fadeIn "slow"
     
   #    $.ajax
   #      url: URL
   #      type: "get"

   #    false
   # ), ->
   #    $(this).next(".auth_form_container").hide()
   #    background_fadeOut.fadeOut "slow"

    
  


  






  


  

  

  





  
  
  



 
  
  



 