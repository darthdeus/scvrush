class UpcomingController < ApplicationController
  def index
    @tournaments = Tournament.recent
    @upcoming = Widget.upcoming_tournaments
  end

end
