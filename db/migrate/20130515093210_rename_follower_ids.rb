class RenameFollowerIds < ActiveRecord::Migration
  def change
    rename_column :users, :follower_ids, :follower_ids_cache
    rename_column :users, :followee_ids, :followee_ids_cache
  end
end
