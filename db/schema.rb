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

ActiveRecord::Schema[7.0].define(version: 2023_06_13_135124) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "day_plans", force: :cascade do |t|
    t.integer "day_number"
    t.bigint "weekly_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weekly_plan_id"], name: "index_day_plans_on_weekly_plan_id"
  end

  create_table "diet_plans", force: :cascade do |t|
    t.jsonb "day_plan_content"
    t.bigint "day_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_plan_id"], name: "index_diet_plans_on_day_plan_id"
  end

  create_table "exercise_plans", force: :cascade do |t|
    t.jsonb "day_plan_content"
    t.bigint "day_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_plan_id"], name: "index_exercise_plans_on_day_plan_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "exercise_type"
    t.string "muscle"
    t.string "difficulty"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "age"
    t.integer "height"
    t.integer "weight"
    t.string "goal"
    t.string "activity_level"
    t.string "gender"
    t.jsonb "bmi"
    t.jsonb "ideal_weight"
    t.jsonb "daily_calories"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workout_difficulty"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "height"
    t.string "dietary_requirements", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "surname"
    t.date "date_of_birth"
    t.string "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_plans", force: :cascade do |t|
    t.string "fitness_goal"
    t.integer "current_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight_goal"
    t.bigint "profile_id"
    t.index ["profile_id"], name: "index_weekly_plans_on_profile_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "day_plans", "weekly_plans"
  add_foreign_key "diet_plans", "day_plans"
  add_foreign_key "exercise_plans", "day_plans"
  add_foreign_key "profiles", "users"
  add_foreign_key "weekly_plans", "profiles"
end
