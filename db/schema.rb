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

ActiveRecord::Schema.define(:version => 20120620184855) do

  create_table "argument_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "argument_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "argument_votes", ["argument_id"], :name => "index_argument_votes_on_argument_id"
  add_index "argument_votes", ["user_id"], :name => "index_argument_votes_on_user_id"

  create_table "arguments", :force => true do |t|
    t.text     "arg"
    t.string   "kind"
    t.integer  "count",      :default => 0
    t.string   "title"
    t.integer  "topic_user_id"
    t.string   "topic_user_email"
    t.string   "user_email"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "arguments", ["topic_id"], :name => "index_arguments_on_topic_id"
  add_index "arguments", ["user_id"], :name => "index_arguments_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topic_votes", :force => true do |t|
    t.integer  "kind"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topic_votes", ["topic_id"], :name => "index_topic_votes_on_topic_id"
  add_index "topic_votes", ["user_id"], :name => "index_topic_votes_on_user_id"

  create_table "topics", :force => true do |t|
    t.text     "title"
    t.integer  "count",      :default => 0
    t.string   "user_email"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
