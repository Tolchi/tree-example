jQuery ->
  $('#companies_table').dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#companies_table").data('source')
    bAutoWidth:  false
