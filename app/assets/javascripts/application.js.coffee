#= require jquery
#= require jquery_ujs
#= require_tree .

jQuery ->
  form_inputs = '.field input, .field textarea'
  $(form_inputs).focus -> $(this).parent().addClass('focused')    
  $(form_inputs).blur  -> $(this).parent().removeClass('focused')
  
  $('.focused input[type=text]').focus()
  
  $.ajax
    url: "http://api.justin.tv/api/stream/list.json?channel=scvrush1"
    dataType: "jsonp"
    success: (data) ->
      if console && console.log
        console.log data
        if data.name == "live_user_scvrush1"
          5.times ->
            console.log "stream is live"
        else
          console.log "stream is dead"