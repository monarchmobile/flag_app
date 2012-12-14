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

ActiveRecord::Schema.define(:version => 20121214175908) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.datetime "date_taken"
    t.boolean  "week"
    t.boolean  "month"
    t.boolean  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.string   "day_p"
    t.string   "week_p"
    t.string   "month_p"
    t.string   "year_p"
    t.string   "day_dim"
    t.string   "week_dim"
    t.string   "month_dim"
    t.string   "year_dim"
  end

  create_table "journals", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "entry_date"
    t.boolean  "day"
    t.boolean  "week"
    t.boolean  "month"
    t.boolean  "year"
  end

  create_table "scrapbooks", :force => true do |t|
    t.string   "period"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "country"
    t.string   "cell"
    t.string   "phone"
    t.string   "school"
    t.string   "family"
    t.integer  "user_type"
    t.boolean  "nav_menu"
    t.string   "auth_token"
  end

end
