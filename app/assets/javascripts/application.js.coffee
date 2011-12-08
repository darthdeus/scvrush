#= require jquery
#= require jquery_ujs
#= require underscore
#= require active_admin

jQuery ->
  form_inputs = '.field input, .field textarea'
  $(form_inputs).focus -> $(this).parent().addClass('focused')    
  $(form_inputs).blur  -> $(this).parent().removeClass('focused')
  
  $('.focused input[type=text]').focus()
  
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
      
      # if console && console.log
      #   console.log data
      #   if data.name == "live_user_scvrush1"
      #     5.times ->
      #       console.log "stream is live"
      #   else
      #     console.log "stream is dead"