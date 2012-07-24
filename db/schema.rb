# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120724161218) do

  create_table "achievements", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches", :force => true do |t|
    t.integer  "order"
    t.string   "title"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches", ["post_id"], :name => "index_coaches_on_post_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "games", :force => true do |t|
    t.integer  "winner",     :null => false
    t.integer  "match_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "games", ["match_id"], :name => "index_games_on_match_id"

  create_table "images", :force => true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "round_id",                      :null => false
    t.boolean  "completed",  :default => false
    t.integer  "seed",                          :null => false
    t.string   "score"
  end

  create_table "pages", :force => true do |t|
    t.string "name",    :null => false
    t.text   "content"
  end

  create_table "points", :force => true do |t|
    t.integer  "value"
    t.string   "reason_type"
    t.integer  "reason_id"
    t.integer  "user_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["reason_id"], :name => "index_points_on_reason_id"
  add_index "points", ["user_id"], :name => "index_points_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "featured_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           :default => 0
    t.integer  "user_id"
    t.datetime "published_at"
    t.boolean  "comments_enabled", :default => true
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "raffle_signups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "raffle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raffle_signups", ["raffle_id"], :name => "index_raffle_signups_on_raffle_id"
  add_index "raffle_signups", ["user_id", "raffle_id"], :name => "index_raffle_signups_on_user_id_and_raffle_id"
  add_index "raffle_signups", ["user_id"], :name => "index_raffle_signups_on_user_id"

  create_table "raffles", :force => true do |t|
    t.integer  "status",     :default => 0
    t.integer  "winner_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raffles", ["winner_id"], :name => "index_raffles_on_winner_id"

  create_table "relationships", :force => true do |t|
    t.integer  "requestor_id",                     :null => false
    t.string   "requestor_type",                   :null => false
    t.integer  "requestee_id",                     :null => false
    t.string   "requestee_type",                   :null => false
    t.boolean  "restricted",     :default => true
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "replies", :force => true do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["topic_id"], :name => "index_replies_on_topic_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rounds", :force => true do |t|
    t.integer "number",        :null => false
    t.integer "tournament_id", :null => false
    t.integer "parent_id"
    t.text    "text"
    t.integer "bo"
  end

  add_index "rounds", ["tournament_id"], :name => "index_rounds_on_tournament_id"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "signups", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.integer  "status",        :default => 0
    t.integer  "placement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signups", ["tournament_id"], :name => "index_signups_on_tournament_id"
  add_index "signups", ["user_id"], :name => "index_signups_on_user_id"

  create_table "statuses", :force => true do |t|
    t.text     "text",            :null => false
    t.integer  "statusable_id"
    t.string   "statusable_type"
    t.integer  "user_id",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "statuses", ["user_id"], :name => "index_statuses_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["tagger_id"], :name => "index_taggings_on_tagger_id"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_reply_id"
    t.datetime "last_reply_at"
  end

  add_index "topics", ["last_reply_id"], :name => "index_topics_on_last_reply_id"
  add_index "topics", ["section_id"], :name => "index_topics_on_section_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "winner_id"
    t.boolean  "seeded",          :default => false
    t.string   "tournament_type"
    t.text     "description"
    t.string   "admins"
    t.text     "rules"
    t.text     "map_info"
    t.string   "bo_preset"
  end

  add_index "tournaments", ["post_id"], :name => "index_tournaments_on_post_id"
  add_index "tournaments", ["winner_id"], :name => "index_tournaments_on_winner_id"

  create_table "user_achievements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_achievements", ["achievement_id"], :name => "index_user_achievements_on_achievement_id"
  add_index "user_achievements", ["user_id", "achievement_id"], :name => "index_user_achievements_on_user_id_and_achievement_id"
  add_index "user_achievements", ["user_id"], :name => "index_user_achievements_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "bnet_username"
    t.string   "bnet_code"
    t.string   "avatar"
    t.string   "race"
    t.string   "league"
    t.string   "server"
    t.string   "favorite_player"
    t.string   "skype"
    t.string   "msn"
    t.boolean  "display_email",          :default => false
    t.boolean  "display_skype",          :default => false
    t.boolean  "display_msn",            :default => false
    t.text     "about"
    t.boolean  "practice"
    t.string   "twitter"
    t.string   "time_zone"
    t.string   "api_key"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
