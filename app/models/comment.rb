class Comment < ActiveRecord::Base
  belongs_to :post, touch: true
  belongs_to :user
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Comment'

  has_many :replies, foreign_key: 'parent_id', class_name: 'Comment'

  validates :content, presence: true, length: { maximum: 800, minimum: 10 }
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

  def self.expand_children(item)
    ary = []
    ary << item[:item]
    ary.push(*(item[:children].map { |child| expand_children(child) }))
    ary.flatten
  end

  def self.threaded_for_post(post_id)
    comments = where(post_id: post_id).includes(:user)
    root, children = comments.partition { |comment| !comment.parent_id.present? }

    sorted = []
    all = []
    root.each do |item|
      node = { item: item, children: [] }
      sorted << node
      all << node
    end

    children.each do |child|
      parent = all.select { |node| node[:item].id == child.parent_id }.first
      node = { item: child, children: [] }
      # If the parent was deleted, we don't want to display the replies,
      # even though they are kept in the database.
      parent[:children] << node if parent
      all << node
    end

    sorted.map { |item| expand_children(item) }.flatten
  end

  def to_simple_json
    {
      id:      self.id,
      content: simple_format(self.content),
      user_id: self.user.id,
      author:  self.user.username,
      date:    time_ago_in_words(self.created_at),
      parent_id: self.parent_id
    }
  end
end
