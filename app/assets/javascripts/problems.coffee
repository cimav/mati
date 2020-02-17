# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', '#problem-close-link', () ->
  $('#problem_status').val(99)
  $('#problem-form').submit()
)

$(document).on('click', '#problem-response-link', () ->
  if $('#problem_message').val() != ''
    $('#problem-form').submit()
)

$(document).on('change', '#problem_agent_id', () ->
  $('#problem-form').submit()
)

$(document).on('change', '#problem_status', () ->
  $('#problem-form').submit()
)

$(document).on('change', '#problem_priority', () ->
  $('#problem-form').submit()
)

