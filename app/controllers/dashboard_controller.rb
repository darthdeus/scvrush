class DashboardController < ApplicationController
  before_filter :require_writer
  
  def index
    @drafts = Post.drafts.limit(5)
    @published = Post.published.limit(5)
  end

end
