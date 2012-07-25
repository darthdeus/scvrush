class BlogPost < ActiveRecord::Base
  validates_presence_of :title, :url, :order

  scope :recent, order('"order" DESC').limit(5)

  before_save :expire_sidebar_cache

  def expire_sidebar_cache
    Rails.cache.delete('views/bloglinks')
    true
  end
end
