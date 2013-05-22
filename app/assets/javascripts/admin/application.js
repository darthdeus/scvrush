//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require ../vendor/select2

$(function() {

  $('.data-table table').dataTable({
    sPaginationType: 'bootstrap',
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('.data-table table').data('source')
  });

  $('.data-table-client table').dataTable({
    sPaginationType: 'bootstrap'
  });

  $('.admin-form select').select2({ width: "element" });

});
