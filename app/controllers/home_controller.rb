class HomeController < ApplicationController
  def index
    @terran_post  = Post.race_post("terran")
    @zerg_post    = Post.race_post("zerg")
    @protoss_post = Post.race_post("protoss")

    @tournament = TournamentDecorator.new(Tournament.upcoming.first)
    @scene_post = PostDecorator.new(Post.published.tagged_with("scene-news").first)

    @zerg_show       = Post.news_posts('zerg-show')
    @watch_the_pros  = Post.news_posts('watch-the-pros')
    @today_i_learned = Post.news_posts('today-i-learned')
    @game_diary      = Post.news_posts('game-diary')
    @deuce_analysis  = Post.news_posts('deuce-analysis')
    @battle_report   = Post.news_posts('battle-report')

    # models = [@posts, @tournaments, @zerg, @terran, @protoss, @zerg_show,
              # @today_i_learned, @game_diary, @deuce_analysis, @battle_report]
    # fresh_when :etag => Digest::MD5.hexdigest(models.to_a.flatten.map(&:updated_at).to_s), :public => true
  end


end
