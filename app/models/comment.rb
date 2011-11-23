class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  validates :content, :presence => true
  validates :user,    :presence => true
  validates :post,    :presence => true

  acts_as_voteable
  
  def author
    self.user.try(:username)    
  end
end
