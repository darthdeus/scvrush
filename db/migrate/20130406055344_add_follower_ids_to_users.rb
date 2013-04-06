class AddFollowerIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :follower_ids, :text
    add_column :users, :followee_ids, :text
  end
end
