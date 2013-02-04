# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  	new AvatarCropper()
  
  	$(".close_form").click ->
  		alert("hi")

class AvatarCropper
	constructor: ->
 		$(".cropbox").Jcrop
 			
		 	onSelect: @update
		 	onChange: @update

	update: (coords) =>
	    $('#image_crop_x').val(coords.x)
	    $('#image_crop_y').val(coords.y)
	    $('#image_crop_w').val(coords.w)
	    $('#image_crop_h').val(coords.h)
	    @updatePreview(coords)

  	updatePreview: (coords) =>
          $('#preview').css
                  width: Math.round(100/coords.w * $('#cropbox').width()) + 'px'
                  height: Math.round(100/coords.h * $('#cropbox').height()) + 'px'
                  marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
                  marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
