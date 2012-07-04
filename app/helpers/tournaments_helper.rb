module TournamentsHelper

  # Tournament signup button
  def signup_button(tour)
    action_params = { controller: :signups, action: :create, id: tour.id }
    link_to action_params, method: :post, class: 'btn btn-success btn-large' do
      html = content_tag(:i, "", class: "icon-ok icon-white")
      html << "Sign up for the tournament"
      html.html_safe
    end
  end


  # Cancel signup button
  def cancel_signup_button(tour)
    action_params = { controller: :signups, action: :create, id: tour.id }
    link_to action_params, method: :post, class: 'btn btn-danger btn-large' do
      html = content_tag(:i, "", class: "icon-remove icon-white")
      html << "Cancel your registraion for the tournament"
      html.html_safe
    end
  end

  def checkin_button(tour)
    # action_params = { controller: :signups, action: :create, id: tour.id }
    # button_to action_params, method: :post, class: 'btn' do
    #   "Sign up for the tournament" + content_tag :i, class: "icon-ok icon-white"
    # end

    button_to "Checkin!",
      { :controller => :signups, :action => :update, :id => tour.id },
        :method => :put, :class => 'btn'
  end

  def is_writer?
    current_user.try(:is_writer?)
  end
end
