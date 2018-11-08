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

$(document).on('change', '#search_type_id', () ->
  select_search(this.value, $('#q').val())
)

$(document).on('keyup', '#q', () ->
  if (this.value.length >= 3) 
    select_search($('#search_type_id').val(), this.value)
)
  
select_search = (t, q) ->
  url = '/cmdb/items/select_search?t=' + t + '&q=' + q 
  $.get url, (data) ->
    $('#select-search-results').html(data)

