head.ready 'jquery.zweatherfeed', ->
  $("#pronostico").weatherfeed [ "KSXX0037", "ARBA0009" ]

head.ready 'select2', -> 
  $("#category_name").select2
    placeholder: "찾고 싶은 카테고리"
    allowClear: true
    mimimumInputLength: 1

head.ready 'bootstrap-collapse', ->
  $(".collapse").collapse

head.ready 'bootstrap-tab', ->
  $("#newstab a").click (e) ->
    e.preventDefault()
    $(this).tab "show"

head.ready 'bootstrap-popover',  ->
  $("#category_name").popover placement: "top"
