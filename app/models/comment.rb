class Comment < ActiveRecord::Base
  belongs_to :post, touch: true
  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 400, :minimum => 10 }
  validates :user,    :presence => true
  validates :post,    :presence => true

  acts_as_voteable

  def author
    self.user.try(:username)
  end
end
