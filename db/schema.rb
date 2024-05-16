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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_130419) do
  create_table "books", charset: "utf8mb3", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "title", limit: 250
    t.string "author", limit: 250
    t.integer "publication_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "borrows", charset: "utf8mb3", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrows_on_book_id"
    t.index ["user_id"], name: "index_borrows_on_user_id"
  end

  create_table "users", charset: "utf8mb3", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "username", limit: 250, null: false
    t.string "password_digest", limit: 250, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
