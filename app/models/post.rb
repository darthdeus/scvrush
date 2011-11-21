class Post < ActiveRecord::Base
  has_many :comments
    
  validates :title, :presence => true #, :uniqueness => true
  validates :content, :presence => true
  
  acts_as_taggable
  
  scope :recent, order("created_at DESC")
end
