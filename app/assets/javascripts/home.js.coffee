$(document).ready ->
  $("#pronostico").weatherfeed [ "KSXX0037", "ARBA0009" ]
$ ->
  $("#category_name").typeahead source: gon.availableCategories

$ ->
  $(".collapse").collapse

$ ->
  $("#newstab a").click (e) ->
    e.preventDefault()
    $(this).pill "show"

$ ->
  $("#nav_search").popover placement: "bottom"

$ ->
  $("#category_name").popover placement: "top"
