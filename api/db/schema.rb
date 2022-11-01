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

ActiveRecord::Schema.define(version: 2022_11_01_113914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "slug"
    t.string "pgn"
    t.integer "result"
    t.integer "game_type"
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

  create_table "puzzle_attempts", force: :cascade do |t|
    t.bigint "solver_id"
    t.bigint "puzzle_id"
    t.integer "time_taken"
    t.integer "status"
    t.string "user_solution"
    t.boolean "rated"
    t.string "solver_type"
    t.index ["puzzle_id"], name: "index_puzzle_attempts_on_puzzle_id"
    t.index ["solver_type", "solver_id"], name: "index_puzzle_attempts_on_solver_type_and_solver_id"
  end

  create_table "puzzles", force: :cascade do |t|
    t.string "starting_position_fen"
    t.string "solution"
    t.string "slug", null: false
    t.integer "initial_popularity", default: 0
    t.integer "upvotes", default: 0
    t.integer "downvotes", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_puzzles_on_slug", unique: true
  end

  create_table "rating_changes", force: :cascade do |t|
    t.bigint "rating_id"
    t.string "target_type"
    t.integer "target_id"
    t.float "rating_change"
    t.float "deviation_change"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "volatility_change"
    t.index ["rating_id"], name: "index_rating_changes_on_rating_id"
    t.index ["target_type", "target_id"], name: "index_rating_changes_on_target_type_and_target_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating_type"
    t.float "rating", default: 1500.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "owner_type"
    t.integer "owner_id"
    t.float "rating_deviation", default: 350.0
    t.float "volatility", default: 0.06
    t.index ["owner_type", "owner_id"], name: "index_ratings_on_owner_type_and_owner_id"
    t.index ["rating"], name: "index_ratings_on_rating"
  end

  create_table "theme_associations", force: :cascade do |t|
    t.bigint "theme_id", null: false
    t.string "associate_type", null: false
    t.integer "associate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["associate_type", "associate_id"], name: "index_theme_associations_on_associate_type_and_associate_id"
    t.index ["theme_id"], name: "index_theme_associations_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_themes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
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
  add_foreign_key "theme_associations", "themes"
end
