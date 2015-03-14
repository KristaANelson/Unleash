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

ActiveRecord::Schema.define(version: 20150312214759) do

  create_table "dogs", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "weight"
    t.string   "breed"
    t.string   "gender"
    t.string   "city"
    t.string   "state"
    t.string   "street"
    t.string   "zipcode"
    t.integer  "user_id"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "dogs", ["user_id"], name: "index_dogs_on_user_id"

  create_table "observations", force: :cascade do |t|
    t.integer  "observed_id"
    t.boolean  "liked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dog_id"
  end

  add_index "observations", ["dog_id"], name: "index_observations_on_dog_id"
  add_index "observations", ["observed_id"], name: "index_observations_on_observed_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "oauth_token"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
