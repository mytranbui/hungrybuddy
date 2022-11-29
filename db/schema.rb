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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_143740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "foodplace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foodplace_id"], name: "index_bookmarks_on_foodplace_id"
    t.index ["list_id"], name: "index_bookmarks_on_list_id"
  end

  create_table "foodplaces", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "type"
    t.string "cuisine"
    t.string "website"
    t.float "google_rating"
    t.date "opening_times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "foodplace_id", null: false
    t.text "comment"
    t.string "highlight"
    t.float "rating"
    t.date "date"
    t.float "cleanliness"
    t.float "service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foodplace_id"], name: "index_reviews_on_foodplace_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "diet"
    t.string "likes"
    t.string "allergies"
    t.string "dislikes"
    t.text "bio"
    t.boolean "updated", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "foodplaces"
  add_foreign_key "bookmarks", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "reviews", "foodplaces"
  add_foreign_key "reviews", "users"
end