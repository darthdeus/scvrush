class Post < ActiveRecord::Base  
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2
  
  has_many :comments
    
  validates :title, :presence => true #, :uniqueness => true
  validates :content, :presence => true
  
  acts_as_taggable
  
  default_scope order("created_at DESC").where(:status => 1)
end
