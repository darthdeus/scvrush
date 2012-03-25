#= require jquery
#= require jquery_ujs
#= require lib/underscore
#= require lib/backbone
#= require active_admin
#= require lib/bootstrap
#= require dashboard

jQuery ->

  url = "http://api.justin.tv/api/stream/list.json"
  $.ajax
    url: url
    dataType: "jsonp"
    data:
      channel: "scvrush1"
    jsonp: "jsonp"
    success: (data) ->
      stream_button = $("li.stream a")
      stream_button.css(color: 'rgba(255, 150, 150, 0.8)')
      stream_button.text('Check out our Stream - LIVE NOW!')

  # $('.btn').click ->
  #   btn = $(this)
  #   btn.button('loading')
  #   setTimeout ->
  #     btn.button('reset')
  #   , 3000

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

  $(".publish_link").click (e) ->
    dialog = $("#publish-date-form")
    post_id = $(this).attr('data-post-id')

    alert("post_id is empty") unless post_id

    dialog.find('form').attr("action", "/posts/" + post_id + "/publish")
    dialog.dialog("open")
    e.preventDefault()
    return false

  $(".datepicker").datepicker()
