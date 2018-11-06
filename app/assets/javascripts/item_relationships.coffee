# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('change', '.rel-radio', () ->
  $('#item-relationship-name').html($('#label-' + this.value).html().toLowerCase())
)

$(document).on('change', '.rel-cb-item', () ->
  selected = [];
  $('.rel-cb-item:checked').each () ->
    selected.push($(this).data('name'))

  $('#item-relationship-to').html(selected.join(', '))
)