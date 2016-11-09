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

ActiveRecord::Schema.define(version: 20161109030058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyer_infos", force: :cascade do |t|
    t.integer  "buyer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phonenumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "config_systems", force: :cascade do |t|
    t.float    "delivery_price"
    t.float    "min_total_cart"
    t.float    "min_quantity"
    t.float    "dispatch_margin_error"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "cuadres", force: :cascade do |t|
    t.datetime "start_date_at"
    t.datetime "end_date_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delivery_routes", force: :cascade do |t|
    t.integer  "urbanization_id"
    t.integer  "residential_id"
    t.integer  "building_id"
    t.string   "addres"
    t.string   "delivery_time"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "zone_id"
    t.integer  "office_id"
    t.boolean  "other",           default: false
  end

  add_index "delivery_routes", ["building_id"], name: "index_delivery_routes_on_building_id", using: :btree
  add_index "delivery_routes", ["office_id"], name: "index_delivery_routes_on_office_id", using: :btree
  add_index "delivery_routes", ["residential_id"], name: "index_delivery_routes_on_residential_id", using: :btree
  add_index "delivery_routes", ["urbanization_id"], name: "index_delivery_routes_on_urbanization_id", using: :btree
  add_index "delivery_routes", ["zone_id"], name: "index_delivery_routes_on_zone_id", using: :btree

  create_table "delivery_times", force: :cascade do |t|
    t.string   "delivery_hours"
    t.string   "max_time_received"
    t.integer  "zone_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "delivery_times", ["zone_id"], name: "index_delivery_times_on_zone_id", using: :btree

  create_table "domiciles", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "delivery_route_id"
    t.string   "home"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "domiciles", ["delivery_route_id"], name: "index_domiciles_on_delivery_route_id", using: :btree

  create_table "media_files", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "media_type",         default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packings", force: :cascade do |t|
    t.integer  "shopping_cart_id"
    t.integer  "packing_type",     default: 0
    t.integer  "quantity",         default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "packings", ["shopping_cart_id"], name: "index_packings_on_shopping_cart_id", using: :btree

  create_table "postulations", force: :cascade do |t|
    t.text     "address"
    t.text     "comment"
    t.string   "email"
    t.integer  "status_postulation", default: 1
    t.string   "motive"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "description"
    t.float    "price"
    t.string   "image"
    t.float    "stock",                     default: 0.0
    t.float    "stock_min",                 default: 0.0
    t.float    "stock_max",                 default: 0.0
    t.integer  "measuring_type",            default: 0
    t.boolean  "active",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imageproduct_file_name"
    t.string   "imageproduct_content_type"
    t.integer  "imageproduct_file_size"
    t.datetime "imageproduct_updated_at"
    t.float    "cost",                      default: 0.0
  end

  create_table "residentials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_items", force: :cascade do |t|
    t.integer  "shopping_cart_id"
    t.integer  "product_id"
    t.float    "quantity",         default: 0.0
    t.float    "amount",           default: 0.0
    t.float    "dispatched",       default: 0.0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "cost",             default: 0.0
  end

  add_index "shopping_cart_items", ["product_id"], name: "index_shopping_cart_items_on_product_id", using: :btree
  add_index "shopping_cart_items", ["shopping_cart_id"], name: "index_shopping_cart_items_on_shopping_cart_id", using: :btree

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "status_cart",    default: 1
    t.datetime "received_at"
    t.float    "delivery_price"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "prepared_at"
    t.datetime "delivered_at"
    t.datetime "rejected"
    t.datetime "cashed_at"
    t.string   "observation"
  end

  add_index "shopping_carts", ["buyer_id"], name: "index_shopping_carts_on_buyer_id", using: :btree

  create_table "urbanizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "type"
    t.boolean  "active",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.integer  "city_id"
    t.float    "delivery_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "zones", ["city_id"], name: "index_zones_on_city_id", using: :btree

end
