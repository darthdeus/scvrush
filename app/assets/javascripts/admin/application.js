//= require jquery
//= require jquery_ujs
//= require vendor/chosen
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap

$(function() {

  $('.data-table table').dataTable({
    sPaginationType: 'bootstrap',
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('#users').data('source')
  });

  $('.admin-form select').chosen();

});
