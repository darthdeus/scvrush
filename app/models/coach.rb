class Coach < ActiveRecord::Base
  
  belongs_to :post
  validates_presence_of :post

  def tags
    post.tags.select { |t| t.name != "coach" }
  end
end
