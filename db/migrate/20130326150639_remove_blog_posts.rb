class RemoveBlogPosts < ActiveRecord::Migration

  def change
    drop_table :blog_posts
  end

end
