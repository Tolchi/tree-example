# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  unless Modernizr.input.placeholder
    $("input").each ->
      if $(this).val() is "" and $(this).attr("placeholder") isnt ""
        $(this).val $(this).attr("placeholder")
        $(this).focus ->
          $(this).val ""  if $(this).val() is $(this).attr("placeholder")

        $(this).blur ->
          $(this).val $(this).attr("placeholder")  if $(this).val() is ""

  $("#slide").carousel interval: 4000
  $("#category_name").typeahead source: gon.availableCategories
  $("a[rel=tooltip]").tooltip
  $(".collapse").collapse
  $("#newstab a").click (e) ->
    e.preventDefault()
    $(this).pill "show"
  $("#nav_search").popover placement: "bottom"
  $("#category_name").popover placement: "top"
