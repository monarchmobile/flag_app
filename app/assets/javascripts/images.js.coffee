# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#image_date_taken').datepicker
		dateFormat: 'yy-mm-dd'

	$(".edit_image input[type=checkbox]").click ->
  		$(this).parent("form").submit()

  	new AvatarCropper()



class AvatarCropper
	constructor: ->
 		$("#cropbox").Jcrop
		 	aspectRatio: 1
		 	setSelect: [0, 0, 600, 600]
		 	onSelect: @update
		 	onChange: @update

	update: (coords) =>
		$('#image_crop_x').val(coords.x)
		$('#image_crop_y').val(coords.y)
		$('#image_crop_w').val(coords.w)
		$('#image_crop_h').val(coords.h)
