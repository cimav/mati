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


$(document).on('change', '#ls_search_type_id', () ->
  $('#items-live-search-form').submit(); 
)

$(document).on('change', '#ls_search_type_id', () ->
  select_search(this.value, $('#ls_item_q').val())
)

$(document).on('keyup', '#ls_item_q', () ->
  if (this.value.length >= 3) 
    select_search($('#ls_search_type_id').val(), this.value)
)
  
select_search = (t, q) ->
  url = '/cmdb/items/live_search?t=' + t + '&q=' + q 
  $.get url, (data) ->
    $('#items-live-search').html(data)