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

ActiveRecord::Schema.define(:version => 20121209231235) do

  create_table "data_points", :force => true do |t|
    t.integer  "flock_id"
    t.integer  "entered_by_id"
    t.date     "occurred_on"
    t.float    "quantity"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "type"
    t.integer  "data_type_id"
  end

  add_index "data_points", ["data_type_id"], :name => "index_data_points_on_data_type_id"
  add_index "data_points", ["entered_by_id"], :name => "index_data_points_on_entered_by_id"
  add_index "data_points", ["flock_id"], :name => "index_data_points_on_flock_id"

  create_table "data_types", :force => true do |t|
    t.integer  "farm_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "type"
  end

  add_index "data_types", ["farm_id"], :name => "index_feed_types_on_farm_id"

  create_table "farmers", :force => true do |t|
    t.integer  "farm_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "farmers", ["farm_id"], :name => "index_farmers_on_farm_id"
  add_index "farmers", ["user_id"], :name => "index_farmers_on_user_id"

  create_table "farms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flocks", :force => true do |t|
    t.string   "name"
    t.integer  "farm_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
