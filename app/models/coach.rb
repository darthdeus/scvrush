class Coach < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :post

  attr_accessible :order, :title, :post_id

  include ActionView::Helpers

  def tags
    post.tags.select { |t| t.name != "coach" }
  end

  def as_json(options = {})
    {
      name: self.post.title,
      link: "/posts/#{self.post.to_param}",
      tags: self.tags.map(&:name)
    }
  end

end
