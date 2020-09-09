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

ActiveRecord::Schema.define(version: 2020_09_09_130105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["client_id"], name: "index_offers_on_client_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "min_quantity", null: false
    t.integer "max_quantity", null: false
    t.jsonb "product_attributes", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_types_on_name"
    t.index ["product_attributes"], name: "index_product_types_on_product_attributes", using: :gin
  end

  create_table "products", force: :cascade do |t|
    t.bigint "product_type_id"
    t.integer "quantity", null: false
    t.float "price", null: false
    t.bigint "offer_id"
    t.jsonb "product_attributes", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_products_on_offer_id"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
  end

  create_table "salesmen", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "offers", "clients"
  add_foreign_key "products", "offers"
  add_foreign_key "products", "product_types"
end
