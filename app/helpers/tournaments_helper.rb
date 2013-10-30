module TournamentsHelper
  def detailed_date(datetime)
    format = "%A %I:%M %P %Z"

    est    = datetime.in_time_zone("Eastern Time (US & Canada)").strftime(format)
    london = datetime.in_time_zone("London").strftime(format)
    mdt    = datetime.in_time_zone("Mountain Time (US & Canada)").strftime(format)

    "#{est}<br>#{london}<br>#{mdt}".html_safe
  end

  def tournament_image(tournament)
    image_tag tournament.image_name
  end

  def cancel_registration_button(registration)
    link_to "Cancel registration",
            tournament_signup_path(registration.tournament, registration.signup),
            method: "delete", class: "btn"
  end

  def registration_button(registration)
    content_tag :button, registration.button_text, class: "btn btn-success", type: "submit"
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
