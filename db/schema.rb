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

ActiveRecord::Schema[7.0].define(version: 2023_09_03_085119) do
  create_table "currency_pairs", charset: "utf8mb3", force: :cascade do |t|
    t.string "label"
    t.string "symbol"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technical_analyses", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "currency_pair_id", null: false
    t.string "trade_setup"
    t.string "trend"
    t.string "pattern"
    t.string "momentum"
    t.string "support_resistance"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_pair_id"], name: "index_technical_analyses_on_currency_pair_id"
    t.index ["user_id"], name: "index_technical_analyses_on_user_id"
  end

  create_table "technical_analysis_records", charset: "utf8mb3", force: :cascade do |t|
    t.string "update_date"
    t.string "asset_symbol"
    t.string "asset_name"
    t.text "description"
    t.string "image_src"
    t.string "near_term_outlook"
    t.string "pattern_type"
    t.string "patter_stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_ideas", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "currency_pair_id", null: false
    t.string "title"
    t.text "description"
    t.string "rating"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_pair_id"], name: "index_trade_ideas_on_currency_pair_id"
    t.index ["user_id"], name: "index_trade_ideas_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "roleType"
    t.string "status"
    t.string "profileImage"
    t.string "accessToken"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "technical_analyses", "currency_pairs"
  add_foreign_key "technical_analyses", "users"
  add_foreign_key "trade_ideas", "currency_pairs"
  add_foreign_key "trade_ideas", "users"
end
