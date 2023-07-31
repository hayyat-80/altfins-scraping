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

ActiveRecord::Schema[7.0].define(version: 2023_07_31_220836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "technical_analysis_records", force: :cascade do |t|
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

end
