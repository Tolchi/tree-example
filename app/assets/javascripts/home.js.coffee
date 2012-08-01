$(document).ready ->
  $("#pronostico").weatherfeed [ "KSXX0037", "ARBA0009" ]
  $("#category_name").select2
    placeholder: "찾고 싶은 카테고리"
    allowClear: true
    mimimumInputLength: 1

$ ->
  $(".collapse").collapse

$ ->
  $("#newstab a").click (e) ->
    e.preventDefault()
    $(this).tab "show"

$ ->
  $("#nav_search").popover placement: "bottom"

$ ->
  $("#category_name").popover placement: "top"
