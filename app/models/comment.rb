class Comment < ActiveRecord::Base
  belongs_to :post, touch: true
  belongs_to :user
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Comment'

  has_many :replies, foreign_key: 'parent_id', class_name: 'Comment'

  validates :content, presence: true, length: { maximum: 400, minimum: 10 }
  validates :user,    presence: true
  validates :post,    presence: true

  attr_accessible :post, :parent, :post_id, :parent_id, :content

  acts_as_voteable

  include ActionView::Helpers

  def author
    self.user.try(:username)
  end

  def date
    time_ago_in_words(self.created_at)
  end

  def self.for_post(post_id)
    where(post_id: post_id).includes(:user).map(&:to_simple_json)
  end

  def to_simple_json
    {
      id:      self.id,
      content: simple_format(self.content),
      user_id: self.user.id,
      author:  self.user.username,
      date:    time_ago_in_words(self.created_at)
    }
  end
end
