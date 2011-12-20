class AddLastReplyToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_reply_id, :integer
    add_column :topics, :last_reply_at, :datetime
  end
end
