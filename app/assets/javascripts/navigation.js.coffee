$(document).ready ->
  unless Modernizr.input.placeholder
    $("input").each ->
      if $(this).val() is "" and $(this).attr("placeholder") isnt ""
        $(this).val $(this).attr("placeholder")
        $(this).focus ->
          $(this).val ""  if $(this).val() is $(this).attr("placeholder")

        $(this).blur ->
          $(this).val $(this).attr("placeholder")  if $(this).val() is ""

