module TournamentsHelper
  def signup_button(tour)
    button_to "Sign up for the tournament", :controller => :signups, :action => :create, :method => :post, :id => tour.id
  end

  def checkin_button(tour)
    button_to "Checkin!", { :controller => :signups, :action => :update, :id => tour.id }, :method => :put
  end
  
  def cancel_signup_button(tour)
    button_to "Cancel your registration for the tournament", { :controller => :signups, :action => :destroy, :id => tour.id }, :method => :delete
  end
end
