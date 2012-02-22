class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :coaches, :post_id
    add_index :points, :reason_id
    add_index :posts, :user_id
    add_index :raffle_signups, :user_id
    add_index :raffle_signups, :raffle_id
    add_index :raffle_signups, [:user_id, :raffle_id]
    add_index :raffles, :winner_id
    add_index :taggings, :tagger_id
    add_index :topics, :last_reply_id
    add_index :tournaments, :post_id
    add_index :tournaments, :winner_id
    add_index :user_achievements, :user_id
    add_index :user_achievements, :achievement_id
    add_index :user_achievements, [:user_id, :achievement_id]
  end

  def down
    remove_index :coaches, :post_id
    remove_index :points, :reason_id
    remove_index :posts, :user_id
    remove_index :raffle_signups, :user_id
    remove_index :raffle_signups, :raffle_id
    remove_index :raffle_signups, [:user_id, :raffle_id]
    remove_index :raffles, :winner_id
    remove_index :taggings, :tagger_id
    remove_index :topics, :last_reply_id
    remove_index :tournaments, :post_id
    remove_index :tournaments, :winner_id
    remove_index :user_achievements, :user_id
    remove_index :user_achievements, :achievement_id
    remove_index :user_achievements, [:user_id, :achievement_id]
  end
end
