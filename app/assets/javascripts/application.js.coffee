#= require jquery
#= require jquery_ujs
#= require lib/jquery.fancybox
#= require lib/underscore
#= require lib/backbone
#= require active_admin
#= require lib/bootstrap
#= require dashboard
#= require login

jQuery ->

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
    dialog = $("#publish-date-form")
    post_id = $(this).attr('data-post-id')

    alert("post_id is empty") unless post_id

    dialog.find('form').attr("action", "/posts/" + post_id + "/publish")
    dialog.dialog("open")
    e.preventDefault()
    return false

  $(".datepicker").datepicker()

  if gon.race
    $('.pick-race button').each ->
      $(this).click() if $(this).text() == gon.race
  else
    $('.pick-race button:first').click()

  if gon.league
    $('.pick-league button').each ->
      $(this).click() if $(this).text() == gon.league
  else
    $('.pick-league button:first').click()

  if gon.server
    $('.pick-server button').each ->
      $(this).click() if $(this).text() == gon.server
  else
    $('.pick-server button:first').click()

