# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_07_134019) do

  create_table "carts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "ci_date", null: false
    t.date "co_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entities", force: :cascade do |t|
    t.integer "property_id", null: false
    t.integer "cart_id"
    t.integer "reservation_id"
    t.date "date", null: false
    t.decimal "price_ratio", default: "0.0"
    t.integer "occupied_status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "properties", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "postal_code", null: false
    t.string "country", null: false
    t.integer "city", default: 0, null: false
    t.string "address", null: false
    t.string "introduction", null: false
    t.string "main_image"
    t.json "sub_images"
    t.boolean "if_dynamic_pricing", default: false
    t.integer "base_price", null: false
    t.integer "min_price"
    t.integer "max_price"
    t.integer "reservation_fee", default: 0
    t.integer "max_capacity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reputations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.decimal "rating", null: false
    t.string "testimonial"
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_reputations_on_property_id"
    t.index ["user_id"], name: "index_reputations_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.string "user_name", null: false
    t.integer "generation", null: false
    t.integer "sex", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.integer "total_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "user_icon"
    t.string "introduction"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reputations", "properties"
  add_foreign_key "reputations", "users"
end
