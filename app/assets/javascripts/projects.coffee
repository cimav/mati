# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('change', '#project_agent_id', () ->
  $('#project-form').submit()
)

$(document).on('change', '#project_status', () ->
  $('#project-form').submit()
)

$(document).on('change', '#project_priority', () ->
  $('#project-form').submit()
)


$(document).on('click', '.remove-task', () ->
  if confirm('¿Eliminar tarea?')
    id = $(this).data('task-id')
    project_id = $(this).data('project-id')

    $.ajax
      url: '/projects/' + project_id + '/tasks/' + id
      type: 'DELETE'
      success: (data) ->
        M.toast html: data.message
        kanban_url = '/project_tasks/kanban/' + project_id
        $.get kanban_url, (data) ->
          $('#kanban-area').html data
      
)