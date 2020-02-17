# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('keyup', '#q_ticket', () ->
  if (this.value.length >= 3) 
    url = '/tickets/select_search?&q=' + this.value
    $.get url, (data) ->
      $('#select-search-results').html(data)
)
