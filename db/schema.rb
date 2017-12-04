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

ActiveRecord::Schema.define(version: 20171204005228) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "make_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer  "model_id",                    null: false
    t.integer  "year",                        null: false
    t.integer  "price",                       null: false
    t.string   "image_file_name",             null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "color"
    t.string   "fuel"
    t.integer  "currency",        default: 0
    t.text     "description"
    t.integer  "quantity"
  end

  add_index "cars", ["model_id"], name: "index_cars_on_model_id"

  create_table "models", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "brand_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "models", ["brand_id"], name: "index_models_on_brand_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "status"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["car_id"], name: "index_orders_on_car_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.boolean  "active"
    t.integer  "sign_in_count"
    t.datetime "last_sign_in_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username"], name: "index_users_on_username"

end
