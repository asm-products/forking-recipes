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

ActiveRecord::Schema.define(:version => 20130128021828) do

  create_table "events", :force => true do |t|
    t.integer   "user_id"
    t.integer   "recipe_id"
    t.text      "action"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "follow", :id => false, :force => true do |t|
    t.integer "following_id"
    t.integer "follower_id"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "recipe_images", :force => true do |t|
    t.integer   "recipe_id"
    t.string    "image"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "recipe_revisions", :force => true do |t|
    t.string    "title"
    t.text      "body"
    t.string    "commit_message"
    t.integer   "user_id"
    t.integer   "recipe_id"
    t.integer   "revision"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  add_index "recipe_revisions", ["user_id"], :name => "index_recipe_revisions_on_user_id"

  create_table "recipes", :force => true do |t|
    t.string    "title"
    t.text      "body"
    t.string    "commit_message"
    t.integer   "revision"
    t.integer   "user_id"
    t.timestamp "created_at",                           :null => false
    t.timestamp "updated_at",                           :null => false
    t.string    "slug"
    t.integer   "forked_from_recipe_id"
    t.integer   "up_votes",              :default => 0, :null => false
    t.integer   "down_votes",            :default => 0, :null => false
  end

  add_index "recipes", ["slug"], :name => "index_recipes_on_slug"
  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
    t.string    "username"
    t.string    "slug"
    t.integer   "up_votes",               :default => 0,  :null => false
    t.integer   "down_votes",             :default => 0,  :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "votings", :force => true do |t|
    t.string    "voteable_type"
    t.integer   "voteable_id"
    t.string    "voter_type"
    t.integer   "voter_id"
    t.boolean   "up_vote",       :null => false
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
