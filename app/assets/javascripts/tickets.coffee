# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', '#ticket-close-link', () ->
  $('#ticket_status').val(99)
  $('#ticket-form').submit()
)

$(document).on('click', '#ticket-response-link', () ->
  if $('#ticket_message').val() != ''
    $('#ticket-form').submit()
)

$(document).on('change', '#ticket_agent_id', () ->
  $('#ticket-form').submit()
)

$(document).on('change', '#ticket_priority', () ->
  $('#ticket-form').submit()
)

