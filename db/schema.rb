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

ActiveRecord::Schema[7.0].define(version: 2024_01_15_121918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "illustrations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "number_of_bananas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "count", default: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_number_of_bananas_on_user_id"
  end

  create_table "training_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "sport_content", null: false
    t.string "bot_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.index ["user_id"], name: "index_training_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "users_illustrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "illustration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["illustration_id"], name: "index_users_illustrations_on_illustration_id"
    t.index ["user_id", "illustration_id"], name: "index_users_illustrations_on_user_id_and_illustration_id", unique: true
    t.index ["user_id"], name: "index_users_illustrations_on_user_id"
  end

  create_table "users_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "target_weight"
    t.boolean "line_notify_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_users_profiles_on_user_id"
  end

  add_foreign_key "number_of_bananas", "users"
  add_foreign_key "training_records", "users"
  add_foreign_key "users_illustrations", "illustrations"
  add_foreign_key "users_illustrations", "users"
  add_foreign_key "users_profiles", "users"
end
