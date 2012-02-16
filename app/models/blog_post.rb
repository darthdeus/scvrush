class BlogPost < ActiveRecord::Base
  scope :recent, order('`order` DESC').limit(5)

  before_save :expire_sidebar_cache

  def expire_sidebar_cache
    # TODO - do this in a better way
    Rails.cache.delete('views/bloglinks')
  end
end
