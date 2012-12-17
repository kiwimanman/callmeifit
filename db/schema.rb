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

ActiveRecord::Schema.define(:version => 20121217082255) do

  create_table "facebook_keys", :force => true do |t|
    t.integer  "user_id"
    t.text     "uid"
    t.text     "info"
    t.text     "token"
    t.datetime "expires_at"
    t.text     "extra"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "phones", :force => true do |t|
    t.integer  "user_id"
    t.string   "international"
    t.string   "number"
    t.string   "extension"
    t.boolean  "verified"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "verification_token"
  end

  create_table "ski_resorts", :force => true do |t|
    t.text     "name"
    t.text     "address_line1"
    t.text     "address_line2"
    t.text     "address_location"
    t.text     "website"
    t.text     "image_url"
    t.text     "webcam_url"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "snow_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ski_resort_id"
    t.integer  "phone_id"
    t.text     "threshold"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.text "name"
  end

end
