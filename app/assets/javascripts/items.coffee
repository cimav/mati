# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('change', '#item_item_type_id', () ->
  item_id = $('.item-workarea').data('id')
  if !item_id
    item_id = ''
  url = '/cmdb/item_types/' + this.value + '/ui/' + item_id 
  $.get url, (data) ->
    $('#extra-fields').html(data)
  
)