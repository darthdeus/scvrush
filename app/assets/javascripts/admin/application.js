//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ../vendor/manifest

//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap

//= require ./backend

$(function() {

  $('.data-table table').dataTable({
    sPaginationType: 'bootstrap',
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('#users').data('source')
  });

  $('.data-table-client table').dataTable({
    sPaginationType: 'bootstrap'
  });

  $('.admin-form select').chosen();

});
