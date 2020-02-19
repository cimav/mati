# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('project', '#project_agent_id', () ->
  $('#project-form').submit()
)

$(document).on('project', '#project_status', () ->
  $('#project-form').submit()
)

$(document).on('project', '#project_priority', () ->
  $('#project-form').submit()
)

