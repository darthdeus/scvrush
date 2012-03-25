class Comment < ActiveRecord::Base
  belongs_to :post, touch: true
  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 400, :minimum => 10 }
  validates :user,    :presence => true
  validates :post,    :presence => true

  acts_as_voteable

  include ActionView::Helpers

  def author
    self.user.try(:username)
  end

  def to_json
    {
      id:      self.id,
      content: simple_format(self.content),
      author:  self.user.username,
      date:    time_ago_in_words(self.created_at)
    }
  end
end
