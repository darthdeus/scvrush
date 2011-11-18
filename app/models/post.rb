class Post < ActiveRecord::Base
  has_many :comments
    
  validates :title, :presence => true, :uniqueness => true
  validates :content, :presence => true
  
  scope :recent, order("created_at DESC").limit(5)
end
