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
      stream_button = $("li.stream a")
      stream_button.css(color: 'rgba(255, 150, 150, 0.8)', marginRight: '35px')
      stream_button.text('Check out our Stream - LIVE NOW!')

  $('.btn').click ->
    btn = $(this)
    btn.button('loading')
    setTimeout ->
      btn.button('reset')
    , 3000
