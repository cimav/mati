# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('click', '#change-response-link', () ->
  if $('#change_message').val() != ''
    $('#change-form').submit()
)

$(document).on('change', '#change_agent_id', () ->
  $('#change-form').submit()
)

$(document).on('change', '#change_status', () ->
  $('#change-form').submit()
)

$(document).on('change', '#change_priority', () ->
  $('#change-form').submit()
)

$(document).on('change', '#change_change_type', () ->
  $('#change-form').submit()
)

$(document).on('change', '#change_risk_type', () ->
  $('#change-form').submit()
)