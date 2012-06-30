//= require jquery
//= require jquery_ujs
//= require lib/chosen
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap

$(function() {

  $('.data-table table').dataTable({
    "sPaginationType": 'bootstrap'
  });

  $('.admin-form select').chosen();

});