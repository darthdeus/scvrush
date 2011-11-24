class DashboardController < ApplicationController
  def index
    @drafts = Post.drafts.limit(5)
    @published = Post.published.limit(5)
  end

end
