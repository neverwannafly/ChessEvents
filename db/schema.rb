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

ActiveRecord::Schema.define(version: 2022_01_09_111742) do

  create_table "games", charset: "utf8mb4", force: :cascade do |t|
    t.string "slug"
    t.string "pgn"
    t.integer "result"
    t.integer "type"
    t.integer "rating_change"
    t.boolean "is_rated"
    t.bigint "white_player_id"
    t.bigint "black_player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["black_player_id"], name: "index_games_on_black_player_id"
    t.index ["slug"], name: "index_games_on_slug", unique: true
    t.index ["white_player_id"], name: "index_games_on_white_player_id"
  end

  create_table "ratings", charset: "utf8mb4", force: :cascade do |t|
    t.integer "type"
    t.bigint "users_id", null: false
    t.integer "rating", default: 1200
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_ratings_on_users_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "games", "users", column: "black_player_id"
  add_foreign_key "games", "users", column: "white_player_id"
  add_foreign_key "ratings", "users", column: "users_id"
end
