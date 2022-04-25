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

ActiveRecord::Schema.define(version: 2022_03_27_113148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "affiliations", force: :cascade do |t|
    t.string "introduction"
    t.integer "circle_state", default: 0, null: false
    t.bigint "user_id", null: false
    t.bigint "circle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circle_id"], name: "index_affiliations_on_circle_id"
    t.index ["user_id", "circle_id"], name: "index_affiliations_on_user_id_and_circle_id", unique: true
    t.index ["user_id"], name: "index_affiliations_on_user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "state", null: false
    t.string "comment"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_attendances_on_event_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "circle_roles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "circle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circle_id"], name: "index_circle_roles_on_circle_id"
  end

  create_table "circles", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "introduction"
    t.integer "state", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_circles_on_user_id"
    t.index ["uuid"], name: "index_circles_on_uuid", unique: true
  end

  create_table "event_roles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_roles_on_event_id"
    t.index ["user_id"], name: "index_event_roles_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "place"
    t.integer "event_fee"
    t.datetime "event_at"
    t.time "event_time"
    t.integer "people_limit_num"
    t.datetime "limit_answer_at"
    t.text "note"
    t.bigint "circle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circle_id"], name: "index_events_on_circle_id"
    t.index ["uuid"], name: "index_events_on_uuid", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_a"
    t.integer "user_b"
    t.integer "user_c"
    t.integer "user_d"
    t.integer "state", default: 0, null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_matches_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "line_user_id", null: false
    t.string "name"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line_user_id", "uuid"], name: "index_users_on_line_user_id_and_uuid", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "affiliations", "circles"
  add_foreign_key "affiliations", "users"
  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "users"
  add_foreign_key "circle_roles", "circles"
  add_foreign_key "circles", "users"
  add_foreign_key "event_roles", "events"
  add_foreign_key "event_roles", "users"
  add_foreign_key "events", "circles"
  add_foreign_key "matches", "events"
end
