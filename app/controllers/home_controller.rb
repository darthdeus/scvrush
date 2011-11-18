class HomeController < ApplicationController
  def index
    @posts = Post.recent.tagged_with('even,tournament', :exclude => true).page(0).limit(6)
    @eu_tournaments = Post.tagged_with('event,eu').limit(3)
    @na_tournaments = Post.tagged_with('event,na').limit(3)
    @tournaments = @eu_tournaments.zip(@na_tournaments).flatten
  end

end
