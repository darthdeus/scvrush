module TournamentsHelper

  def tournament_image(tournament)
    image_tag tournament.image_name
  end

  def tournament_button(tour, text, options)
    action_params = { controller: :signups, action: options[:action], id: tour.id }
    link_to action_params, method: options[:method], class: "btn btn-large #{options[:class]}" do
      html = content_tag(:i, "", class: "#{options[:icon]} icon-white")
      html << text
      html.html_safe
    end
  end

  # Cancel signup button
  def cancel_signup_button(tour)
    text    = "Cancel your registration for the tournament"
    options = {
      action: :destroy,
      method: :delete,
      class: "btn-danger",
      icon: "icon-remove"
    }
    tournament_button(tour, text, options)
  end

  def checkin_button(tour, text = "Check in")
    options = {
      action: :update,
      method: :put,
      class: "btn-success",
      icon: "icon-ok"
    }
    tournament_button(tour, text, options)
  end

  def signup_button(tour, text = "Sign up for the tournament")
    options = {
      action: :create,
      method: :post,
      class: "btn-success",
      icon: "icon-ok"
    }
    tournament_button(tour, text, options)
  end


  def submit_match_result_button
    confirm = "Are you sure? Once you submit the match result, you will have to contact an admin to change it."
    content = '<i class="icon-ok icon-white"></i>Submit the result'
    button_tag type: "submit", class: "btn btn-success btn-large", :"data-confirm" => confirm do
      content.html_safe
    end
  end

  # Button to start a tournament right now
  def start_tournament_button
    link_to("Start now",
      start_tournament_path(@tournament),
      method: :post, class: "btn",
      :'data-confirm' => "Are you sure you want to start the tournament?")
  end

#   def checkin_button(tour)
#     # action_params = { controller: :signups, action: :create, id: tour.id }
#     # button_to action_params, method: :post, class: 'btn' do
#     #   "Sign up for the tournament" + content_tag :i, class: "icon-ok icon-white"
#     # end
#
#     button_to "Checkin!",
#       { :controller => :signups, :action => :update, :id => tour.id },
#         :method => :put, :class => 'btn'
#   end

end
