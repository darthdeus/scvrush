class AddPublishedAtToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :published_at, :datetime
    Post.all.each do |p|
      if p.status == Post::PUBLISHED
        p.published_at = p.created_at
        p.save!
      end
    end
  end

  def down
    remove_column :posts, :published_at
  end
end
