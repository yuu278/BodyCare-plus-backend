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

ActiveRecord::Schema[7.1].define(version: 2025_12_12_210206) do
  create_table "body_assessments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "assessment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pain_area"
    t.json "pain_types"
    t.json "duration"
    t.json "job_types"
    t.json "exercise_habits"
    t.json "posture_habits"
    t.index ["user_id"], name: "index_body_assessments_on_user_id"
  end

  create_table "stretches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.string "video_url"
    t.string "target_area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "muscle_info"
    t.json "pain_type"
    t.json "job_type"
    t.json "exercise_habit"
    t.json "posture_habit"
    t.string "body_part"
    t.json "duration"
  end

  create_table "user_stretches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stretch_id", null: false
    t.boolean "recommended"
    t.integer "completed_count"
    t.datetime "last_completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stretch_id"], name: "index_user_stretches_on_stretch_id"
    t.index ["user_id"], name: "index_user_stretches_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "body_assessments", "users"
  add_foreign_key "user_stretches", "stretches"
  add_foreign_key "user_stretches", "users"
end
