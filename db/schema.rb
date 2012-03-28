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

ActiveRecord::Schema.define(:version => 1) do

  create_table "packages", :force => true do |t|
    t.integer  "tracking_number",   :null => false
    t.string   "resident_name",     :null => false
    t.integer  "resident_id"
    t.datetime "datetime_received", :null => false
    t.string   "carrier"
    t.string   "unit",              :null => false
    t.string   "building",          :null => false
    t.integer  "room",              :null => false
    t.integer  "clerk_received_id"
    t.integer  "clerk_accepted_id"
    t.datetime "datetime_accepted"
    t.string   "sender_address"
    t.string   "sender_city"
    t.string   "sender_state"
    t.integer  "sender_zip"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residents", :force => true do |t|
    t.string  "user_id"
    t.string  "name"
    t.string  "unit"
    t.string  "building"
    t.integer "room"
    t.string  "preference"
    t.integer "phone_number"
    t.string  "email"
  end

end
