class Post < ActiveRecord::Base
  has_many :taggins
  has_many :tags, :through => :taggings
    
  validates :title, :presence => true
  validates :content, :presence => true
end
