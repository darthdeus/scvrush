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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130913185734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battle_reports", force: true do |t|
    t.string   "title",           null: false
    t.text     "content",         null: false
    t.integer  "tournament_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vod"
    t.string   "next_tournament"
    t.string   "team_liquid"
  end

  create_table "coaches", force: true do |t|
    t.string "name"
    t.text   "about"
    t.string "races",     array: true
    t.string "servers",   array: true
    t.string "languages", array: true
  end

  create_table "followings", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "round_id",                   null: false
    t.boolean  "completed",  default: false
    t.integer  "seed",                       null: false
    t.string   "score"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id",                        null: false
    t.boolean  "unread",          default: true
    t.text     "text",                           null: false
    t.integer  "notifiable_id",                  null: false
    t.string   "notifiable_type",                null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "pages", force: true do |t|
    t.string "name",    null: false
    t.text   "content"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "featured_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           default: 0
    t.integer  "user_id"
    t.datetime "published_at"
    t.boolean  "comments_enabled", default: true
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rounds", force: true do |t|
    t.integer "number",        null: false
    t.integer "tournament_id", null: false
    t.integer "parent_id"
    t.text    "text"
    t.integer "bo"
  end

  add_index "rounds", ["tournament_id"], name: "index_rounds_on_tournament_id", using: :btree

  create_table "signups", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.integer  "status",        default: 0
    t.integer  "placement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signups", ["tournament_id"], name: "index_signups_on_tournament_id", using: :btree
  add_index "signups", ["user_id"], name: "index_signups_on_user_id", using: :btree

  create_table "statuses", force: true do |t|
    t.text     "text",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winner_id"
    t.boolean  "seeded",                    default: false
    t.string   "tournament_type"
    t.text     "description"
    t.text     "rules"
    t.text     "map_info"
    t.string   "bo_preset"
    t.text     "map_preset"
    t.integer  "user_id"
    t.boolean  "visible"
    t.string   "channel"
    t.string   "logo"
    t.integer  "max_players"
    t.string   "region"
    t.integer  "signups_count",             default: 0
    t.string   "leagues",                   default: [],    array: true
    t.text     "description_after_bracket"
  end

  add_index "tournaments", ["winner_id"], name: "index_tournaments_on_winner_id", using: :btree

  create_table "users", force: true do |t|
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
    t.boolean  "display_email",          default: false
    t.boolean  "display_skype",          default: false
    t.boolean  "display_msn",            default: false
    t.text     "about"
    t.boolean  "practice"
    t.string   "twitter"
    t.string   "time_zone"
    t.string   "api_key"
    t.datetime "expires_at"
    t.text     "follower_ids_cache"
    t.text     "followee_ids_cache"
  end

  add_index "users", ["expires_at"], name: "index_users_on_expires_at", using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "voteable_id",   null: false
    t.string   "voteable_type", null: false
    t.integer  "user_id",       null: false
    t.integer  "value",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
