module TournamentsHelper

  # Tournament signup button
  def signup_button(tour, text = "Sign up for the tournament")
    action_params = { controller: :signups, action: :create, id: tour.id }
    link_to action_params, method: :post, class: 'btn btn-success btn-large' do
      html = content_tag(:i, "", class: "icon-ok icon-white")
      html << text
      html.html_safe
    end
  end

  # Cancel signup button
  def cancel_signup_button(tour)
    action_params = { controller: :signups, action: :destroy, id: tour.id }
    link_to action_params, method: :delete, class: 'btn btn-danger btn-large' do
      html = content_tag(:i, "", class: "icon-remove icon-white")
      html << "Cancel your registration for the tournament"
      html.html_safe
    end
  end

  def checkin_button(tour, text = "Check in")
    action_params = { controller: :signups, action: :update, id: tour.id }
    link_to action_params, method: :put, class: 'btn btn-success btn-large' do
      html = content_tag(:i, "", class: "icon-ok icon-white")
      html << text
      html.html_safe
    end
  end

  def submit_match_result_button
    confirm = "Are you sure? Once you submit the match result, you will have to contact an admin to change it."
    content = '<i class="icon-ok icon-white"></i>Submit the result'
    button_tag type: "submit", class: "btn btn-success btn-large", :"data-confirm" => confirm do
      content.html_safe
    end
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

  def is_writer?
    current_user.try(:is_writer?)
  end
end
