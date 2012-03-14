class HomeController < ApplicationController
  def index
    # TODO - does #tagged_with consider all tags, or only one of the list?
    @posts = Post.published.tagged_with('event,tournament,zerg-show', :exclude => true).page(0).limit(6)
    @eu_tournaments = Post.published.tagged_with('event,eu').limit(3)
    @na_tournaments = Post.published.tagged_with('event,na').limit(3)
    @tournaments = @eu_tournaments.zip(@na_tournaments).flatten


    # TODO - why am I using page(0) all over the place?
    @zerg    = Post.published.tagged_with('zerg').limit(6)
    @terran  = Post.published.tagged_with('terran').limit(6)
    @protoss = Post.published.tagged_with('protoss').limit(6)

    @zerg_show       = Post.published.tagged_with('zerg-show').page(0).limit(6)
    @watch_the_pros  = Post.published.tagged_with('watch-the-pros').page(0).limit(6)
    @today_i_learned = Post.published.tagged_with('today-i-learned').page(0).limit(6)
    @game_diary      = Post.published.tagged_with('game-diary').page(0).limit(6)
    @deuce_analysis  = Post.published.tagged_with('deuce-analysis').page(0).limit(6)

    @battle_report = Post.published.tagged_with('battle-report').page(0).limit(6)

    # models = [@posts, @tournaments, @zerg, @terran, @protoss, @zerg_show,
              # @today_i_learned, @game_diary, @deuce_analysis, @battle_report]
    # fresh_when :etag => Digest::MD5.hexdigest(models.to_a.flatten.map(&:updated_at).to_s), :public => true
  end


end
