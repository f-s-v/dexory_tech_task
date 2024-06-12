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

ActiveRecord::Schema[7.1].define(version: 2024_06_10_001843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comparison_report_items", force: :cascade do |t|
    t.bigint "location_id"
    t.string "expected_barcodes", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "comparison_report_id"
    t.index ["comparison_report_id"], name: "index_comparison_report_items_on_comparison_report_id"
    t.index ["location_id"], name: "index_comparison_report_items_on_location_id"
  end

  create_table "comparison_reports", force: :cascade do |t|
    t.bigint "scan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scan_id"], name: "index_comparison_reports_on_scan_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "scan_items", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "scan_id", null: false
    t.boolean "occupied"
    t.boolean "scanned"
    t.string "detected_barcodes", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_scan_items_on_location_id"
    t.index ["scan_id"], name: "index_scan_items_on_scan_id"
  end

  create_table "scans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comparison_report_items", "locations"
  add_foreign_key "comparison_reports", "scans"
  add_foreign_key "scan_items", "locations"
  add_foreign_key "scan_items", "scans"
end
