class BlogPost < ActiveRecord::Base
  validates_presence_of :title, :url, :order

  scope :recent, order('`order` DESC').limit(5)

  before_save :expire_sidebar_cache

  def expire_sidebar_cache
    # TODO - do this in a better way
    Rails.cache.delete('views/bloglinks')
  end
end
