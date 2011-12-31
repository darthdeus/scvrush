class UpcomingController < ApplicationController
  # TODO - delete this controller, it's not used anymore
  def index
    @tournaments = Tournament.recent
    @upcoming = Widget.upcoming_tournaments
  end

end
