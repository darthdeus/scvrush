class AddCommentsEnabledToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_enabled, :boolean, default: true
  end
end
