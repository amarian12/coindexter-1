# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
	$('ul#info-menu > li').click ->
		selector = 'ul#' + $(this).attr 'id'
		$('.show-all').removeClass 'active-item'
		$('ul.networks-in-categories').hide()
		$(selector).show()
	$('#show-all').click ->
		$('ul.networks-in-categories').show()