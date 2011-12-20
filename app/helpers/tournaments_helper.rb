module TournamentsHelper
  def signup_button(tour)
    button_to "Sign up for the tournament",
      { :controller => :signups, :action => :create },
        :method => :post, :id => tour.id, :class => 'btn'
  end

  def checkin_button(tour)
    button_to "Checkin!", 
      { :controller => :signups, :action => :update, :id => tour.id },
        :method => :put, :class => 'btn'
  end

  def cancel_signup_button(tour)
    button_to "Cancel your registration for the tournament",
      { :controller => :signups, :action => :destroy, :id => tour.id },
        :method => :delete, :class => 'btn'
  end

  def is_writer?
    current_user.try(:is_writer?)
  end
end
