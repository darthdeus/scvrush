#= require jquery
#= require jquery_ujs
#= require lib/jquery.fancybox
#= require lib/underscore
#= require lib/backbone
#= require lib/bootstrap
#= require dashboard
#= require dataTables/jquery.dataTables
#= require dataTables/jquery.dataTables.bootstrap
#= require login

jQuery ->

  $('.data-table').dataTable({
      "sPaginationType": "bootstrap"
      # "bAutoWidth": false
      # "oLanguage": {
      #   "sLengthMenu": "_MENU_ records per page"
      #     }
    })


  $('.carousel').carousel({ interval: 3500 })

  window.gon = {} unless window.gon?

  url = "http://api.justin.tv/api/stream/list.json"
  $.ajax
    url: url
    dataType: "jsonp"
    data:
      channel: "scvrush1"
    jsonp: "jsonp"
    success: (data) ->
      $("li.stream a")
        .css('color', 'rgba(255, 150, 150, 0.8)')
        .text('Check out our Stream - LIVE NOW!')

  $('#new_comment').submit (e) ->
    self = $(this)
    textarea = self.find('[data-required]')
    if textarea.val() == ''
      textarea.parent('fieldset').addClass('error')
      textarea.focus()
      self.find('.btn').button('reset')
      return false
    else
      textarea.parent('fieldset').removeClass('error')

  $('#publish-date-form').dialog {
    autoOpen: false,
    modal: true,
    width: 300,
    height: 150
  }

  $('.pick-race button').click ->
    $('#picked-race').val $(this).text()

  $('.pick-server button').click ->
    $('#picked-server').val $(this).text()

  $('.pick-league button').click ->
    $('#picked-league').val $(this).text()


  $(".publish_link").click (e) ->
    e.preventDefault()
    dialog = $("#publish-date-form")
    post_id = $(this).attr('data-post-id')

    alert("post_id is empty") unless post_id

    dialog.find('form').attr("action", "/posts/#{post_id}/publish")
    dialog.dialog("open")

  $(".datepicker").datepicker()


  for filter in ['race', 'league', 'server']
    if gon[filter]
      $(".pick-#{filter} button").each ->
        $(this).click() if $(this).text() == gon[filter]
    else
      $(".pick-#{filter} button:first").click()
