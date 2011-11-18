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

ActiveRecord::Schema.define(:version => 20111117233745) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["category_id"], :name => "index_articles_on_category_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "featured_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["post_id"], :name => "index_taggings_on_post_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wp_commentmeta", :primary_key => "meta_id", :force => true do |t|
    t.integer "comment_id", :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_commentmeta", ["comment_id"], :name => "comment_id"
  add_index "wp_commentmeta", ["meta_key"], :name => "meta_key"

  create_table "wp_comments", :primary_key => "comment_ID", :force => true do |t|
    t.integer  "comment_post_ID",      :limit => 8,   :default => 0,   :null => false
    t.text     "comment_author",       :limit => 255,                  :null => false
    t.string   "comment_author_email", :limit => 100, :default => "",  :null => false
    t.string   "comment_author_url",   :limit => 200, :default => "",  :null => false
    t.string   "comment_author_IP",    :limit => 100, :default => "",  :null => false
    t.datetime "comment_date",                                         :null => false
    t.datetime "comment_date_gmt",                                     :null => false
    t.text     "comment_content",                                      :null => false
    t.integer  "comment_karma",                       :default => 0,   :null => false
    t.string   "comment_approved",     :limit => 20,  :default => "1", :null => false
    t.string   "comment_agent",                       :default => "",  :null => false
    t.string   "comment_type",         :limit => 20,  :default => "",  :null => false
    t.integer  "comment_parent",       :limit => 8,   :default => 0,   :null => false
    t.integer  "user_id",              :limit => 8,   :default => 0,   :null => false
  end

  add_index "wp_comments", ["comment_approved", "comment_date_gmt"], :name => "comment_approved_date_gmt"
  add_index "wp_comments", ["comment_approved"], :name => "comment_approved"
  add_index "wp_comments", ["comment_date_gmt"], :name => "comment_date_gmt"
  add_index "wp_comments", ["comment_parent"], :name => "comment_parent"
  add_index "wp_comments", ["comment_post_ID"], :name => "comment_post_ID"

  create_table "wp_links", :primary_key => "link_id", :force => true do |t|
    t.string   "link_url",                             :default => "",  :null => false
    t.string   "link_name",                            :default => "",  :null => false
    t.string   "link_image",                           :default => "",  :null => false
    t.string   "link_target",      :limit => 25,       :default => "",  :null => false
    t.string   "link_description",                     :default => "",  :null => false
    t.string   "link_visible",     :limit => 20,       :default => "Y", :null => false
    t.integer  "link_owner",       :limit => 8,        :default => 1,   :null => false
    t.integer  "link_rating",                          :default => 0,   :null => false
    t.datetime "link_updated",                                          :null => false
    t.string   "link_rel",                             :default => "",  :null => false
    t.text     "link_notes",       :limit => 16777215,                  :null => false
    t.string   "link_rss",                             :default => "",  :null => false
  end

  add_index "wp_links", ["link_visible"], :name => "link_visible"

  create_table "wp_live_countdown_timer_timers", :primary_key => "xID", :force => true do |t|
    t.integer "xPostID",                :null => false
    t.string  "xValues", :limit => 254, :null => false
  end

  create_table "wp_options", :primary_key => "option_id", :force => true do |t|
    t.integer "blog_id",                            :default => 0,     :null => false
    t.string  "option_name",  :limit => 64,         :default => "",    :null => false
    t.text    "option_value", :limit => 2147483647,                    :null => false
    t.string  "autoload",     :limit => 20,         :default => "yes", :null => false
  end

  add_index "wp_options", ["option_name"], :name => "option_name", :unique => true

  create_table "wp_postmeta", :primary_key => "meta_id", :force => true do |t|
    t.integer "post_id",    :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_postmeta", ["meta_key"], :name => "meta_key"
  add_index "wp_postmeta", ["post_id"], :name => "post_id"

  create_table "wp_posts", :primary_key => "ID", :force => true do |t|
    t.integer  "post_author",           :limit => 8,          :default => 0,         :null => false
    t.datetime "post_date",                                                          :null => false
    t.datetime "post_date_gmt",                                                      :null => false
    t.text     "post_content",          :limit => 2147483647,                        :null => false
    t.text     "post_title",                                                         :null => false
    t.text     "post_excerpt",                                                       :null => false
    t.string   "post_status",           :limit => 20,         :default => "publish", :null => false
    t.string   "comment_status",        :limit => 20,         :default => "open",    :null => false
    t.string   "ping_status",           :limit => 20,         :default => "open",    :null => false
    t.string   "post_password",         :limit => 20,         :default => "",        :null => false
    t.string   "post_name",             :limit => 200,        :default => "",        :null => false
    t.text     "to_ping",                                                            :null => false
    t.text     "pinged",                                                             :null => false
    t.datetime "post_modified",                                                      :null => false
    t.datetime "post_modified_gmt",                                                  :null => false
    t.text     "post_content_filtered",                                              :null => false
    t.integer  "post_parent",           :limit => 8,          :default => 0,         :null => false
    t.string   "guid",                                        :default => "",        :null => false
    t.integer  "menu_order",                                  :default => 0,         :null => false
    t.string   "post_type",             :limit => 20,         :default => "post",    :null => false
    t.string   "post_mime_type",        :limit => 100,        :default => "",        :null => false
    t.integer  "comment_count",         :limit => 8,          :default => 0,         :null => false
  end

  add_index "wp_posts", ["post_author"], :name => "post_author"
  add_index "wp_posts", ["post_name"], :name => "post_name"
  add_index "wp_posts", ["post_parent"], :name => "post_parent"
  add_index "wp_posts", ["post_type", "post_status", "post_date", "ID"], :name => "type_status_date"

  create_table "wp_stoutgc", :force => true do |t|
    t.text    "name",             :limit => 255, :null => false
    t.text    "googlecalcode",                   :null => false
    t.string  "color0",           :limit => 32,  :null => false
    t.string  "color1",           :limit => 32,  :null => false
    t.string  "color2",           :limit => 32,  :null => false
    t.string  "color3",           :limit => 32,  :null => false
    t.string  "color4",           :limit => 32,  :null => false
    t.string  "color5",           :limit => 32,  :null => false
    t.string  "color6",           :limit => 32,  :null => false
    t.boolean "bkgrdTransparent",                :null => false
    t.integer "bkgrdImage",       :limit => 3,   :null => false
    t.string  "bubble_width",     :limit => 32,  :null => false
  end

  add_index "wp_stoutgc", ["id"], :name => "id", :unique => true

  create_table "wp_term_relationships", :id => false, :force => true do |t|
    t.integer "object_id",        :limit => 8, :default => 0, :null => false
    t.integer "term_taxonomy_id", :limit => 8, :default => 0, :null => false
    t.integer "term_order",                    :default => 0, :null => false
  end

  add_index "wp_term_relationships", ["term_taxonomy_id"], :name => "term_taxonomy_id"

  create_table "wp_term_taxonomy", :primary_key => "term_taxonomy_id", :force => true do |t|
    t.integer "term_id",     :limit => 8,          :default => 0,  :null => false
    t.string  "taxonomy",    :limit => 32,         :default => "", :null => false
    t.text    "description", :limit => 2147483647,                 :null => false
    t.integer "parent",      :limit => 8,          :default => 0,  :null => false
    t.integer "count",       :limit => 8,          :default => 0,  :null => false
  end

  add_index "wp_term_taxonomy", ["taxonomy"], :name => "taxonomy"
  add_index "wp_term_taxonomy", ["term_id", "taxonomy"], :name => "term_id_taxonomy", :unique => true

  create_table "wp_terms", :primary_key => "term_id", :force => true do |t|
    t.string  "name",       :limit => 200, :default => "", :null => false
    t.string  "slug",       :limit => 200, :default => "", :null => false
    t.integer "term_group", :limit => 8,   :default => 0,  :null => false
  end

  add_index "wp_terms", ["name"], :name => "name"
  add_index "wp_terms", ["slug"], :name => "slug", :unique => true

  create_table "wp_usermeta", :primary_key => "umeta_id", :force => true do |t|
    t.integer "user_id",    :limit => 8,          :default => 0, :null => false
    t.string  "meta_key"
    t.text    "meta_value", :limit => 2147483647
  end

  add_index "wp_usermeta", ["meta_key"], :name => "meta_key"
  add_index "wp_usermeta", ["user_id"], :name => "user_id"

  create_table "wp_users", :primary_key => "ID", :force => true do |t|
    t.string   "user_login",          :limit => 60,  :default => "", :null => false
    t.string   "user_pass",           :limit => 64,  :default => "", :null => false
    t.string   "user_nicename",       :limit => 50,  :default => "", :null => false
    t.string   "user_email",          :limit => 100, :default => "", :null => false
    t.string   "user_url",            :limit => 100, :default => "", :null => false
    t.datetime "user_registered",                                    :null => false
    t.string   "user_activation_key", :limit => 60,  :default => "", :null => false
    t.integer  "user_status",                        :default => 0,  :null => false
    t.string   "display_name",        :limit => 250, :default => "", :null => false
  end

  add_index "wp_users", ["user_login"], :name => "user_login_key"
  add_index "wp_users", ["user_nicename"], :name => "user_nicename"

end
