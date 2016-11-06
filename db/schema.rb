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

ActiveRecord::Schema.define(version: 20161105210118) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "selected",   default: false
    t.integer  "status"
    t.float    "longitude"
    t.float    "latitude"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "status"
    t.string   "label"
    t.integer  "votes",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "business_name"
    t.string   "business_id"
    t.string   "vat"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "contact_person"
    t.string   "phone"
    t.string   "email"
  end

  create_table "opt_ins", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_groups", force: :cascade do |t|
    t.string   "label"
    t.string   "description"
    t.integer  "order"
    t.integer  "venue_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.index ["venue_id"], name: "index_product_groups_on_venue_id"
  end

  create_table "product_variations", force: :cascade do |t|
    t.string   "label"
    t.boolean  "allow_multi_choices", default: false
    t.integer  "product_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "multi_choice_limit",  default: 0
    t.integer  "order"
    t.index ["product_id"], name: "index_product_variations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "product_group_id"
    t.string   "label"
    t.string   "description"
    t.float    "base_price"
    t.integer  "status"
    t.integer  "order"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["product_group_id"], name: "index_products_on_product_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "remember_digest"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "credits",         default: 0.0
    t.string   "invitation_code"
    t.string   "phone"
    t.string   "name"
    t.string   "stripe_id"
    t.string   "profile_picture"
  end

  create_table "variation_options", force: :cascade do |t|
    t.string   "label"
    t.boolean  "allow_multi_choices",  default: false
    t.float    "price_variation",      default: 0.0
    t.integer  "product_variation_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "multi_choice_limit",   default: 0
    t.boolean  "default",              default: false
    t.integer  "order"
    t.index ["product_variation_id"], name: "index_variation_options_on_product_variation_id"
  end

  create_table "venues", force: :cascade do |t|
    t.integer  "status"
    t.string   "name"
    t.string   "title"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "merchant_id"
    t.integer  "city_id"
    t.boolean  "accepts_take_away"
    t.boolean  "accepts_delivery"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "city_name"
    t.string   "description"
    t.string   "venue_picture"
    t.string   "venue_thumbnail_picture"
    t.index ["city_id"], name: "index_venues_on_city_id"
    t.index ["merchant_id"], name: "index_venues_on_merchant_id"
  end

end
