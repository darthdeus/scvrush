#= require jquery
#= require jquery_ujs
#= require underscore
#= require active_admin
#= require bootstrap
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
      stream_button = $("#navigation li.stream")
      stream_button.css backgroundColor: 'rgba(255, 0, 0, 0.2)'

      stream_button.find("a").text("Check out our stream - Live!")

  $('.btn').click ->
    btn = $(this)
    btn.button('loading')
    setTimeout ->
      btn.button('reset')
    , 3000
