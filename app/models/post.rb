class Post < ActiveRecord::Base
  has_many :taggins
  has_many :tags, :through => :taggings
  has_many :comments
    
  validates :title, :presence => true
  validates :content, :presence => true
  
  scope :recent, order("created_at DESC").limit(5)
end
