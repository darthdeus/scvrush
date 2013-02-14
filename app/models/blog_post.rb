class BlogPost < ActiveRecord::Base
  validates_presence_of :title, :url, :order
  scope :recent, order('"order" DESC').limit(5)
  attr_accessible :title, :url, :order
end
