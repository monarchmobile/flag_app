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

ActiveRecord::Schema.define(:version => 20130419132455) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "title"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "current_state"
    t.integer  "position"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "location"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "slug"
    t.text     "body"
    t.date     "event_start"
    t.date     "event_end"
    t.boolean  "featured"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "current_state"
    t.integer  "position"
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
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "image"
    t.string   "day_p"
    t.string   "week_p"
    t.string   "month_p"
    t.string   "year_p"
    t.string   "day_dim"
    t.string   "week_dim"
    t.string   "month_dim"
    t.string   "year_dim"
    t.integer  "day_z",      :default => 500
    t.integer  "week_z",     :default => 500
    t.integer  "month_z",    :default => 500
    t.integer  "year_z",     :default => 500
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

  create_table "links", :force => true do |t|
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "links_pages", :id => false, :force => true do |t|
    t.integer "link_id"
    t.integer "page_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.integer  "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "current_state"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "scrapbooks", :force => true do |t|
    t.string   "period"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "status_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "statuses_statusables", :id => false, :force => true do |t|
    t.integer "status_id"
    t.integer "statusable_id"
    t.string  "statusable_type"
  end

  create_table "supermodels", :force => true do |t|
    t.string   "name"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
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
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "guest"
    t.string   "member_photo"
    t.boolean  "approved",               :default => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "owner_id"
    t.date     "beg_range"
    t.integer  "range_type"
    t.integer  "user_id"
    t.boolean  "voted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
