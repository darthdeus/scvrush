class HomeController < ApplicationController
  def index
    # TODO - does #tagged_with consider all tags, or only one of the list?
    @posts = Post.published.tagged_with('event,tournament,zerg-show', :exclude => true).page(0).limit(6)
    @eu_tournaments = Post.tagged_with('event,eu').limit(3)
    @na_tournaments = Post.tagged_with('event,na').limit(3)
    @tournaments = @eu_tournaments.zip(@na_tournaments).flatten
    @zerg = Post.published.tagged_with('zerg-show').page(0).limit(6)
  end

end
