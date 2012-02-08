jQuery ->
  $('#ggbet_logo_checkbox').click (e) ->
    self = $(this)
    if self.is(':checked')
      $.get '/dashboard/ggbet', ggbet_logo: 1
    else
      $.get '/dashboard/ggbet', ggbet_logo: 0

  $('#ggbet_widget_checkbox').click (e) ->
    self = $(this)
    if self.is(':checked')
      $.get '/dashboard/ggbet', ggbet_widget: 1
    else
      $.get '/dashboard/ggbet', ggbet_widget: 0
