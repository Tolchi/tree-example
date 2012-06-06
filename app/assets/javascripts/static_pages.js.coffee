# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".carousel").carousel()

  unless Modernizr.input.placeholder
    $("input").each ->
      if $(this).val() is "" and $(this).attr("placeholder") isnt ""
        $(this).val $(this).attr("placeholder")
        $(this).focus ->
          $(this).val ""  if $(this).val() is $(this).attr("placeholder")

        $(this).blur ->
          $(this).val $(this).attr("placeholder")  if $(this).val() is ""

  $("#category_name").autocomplete source: gon.availableCategories
