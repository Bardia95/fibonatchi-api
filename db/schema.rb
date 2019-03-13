# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_13_003735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.string "image_url"
    t.integer "recalled", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "paragraph_id"
    t.bigint "user_id"
    t.index ["paragraph_id"], name: "index_cards_on_paragraphs_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "mental_models", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_mental_models_on_user_id"
  end

  create_table "paragraphs", force: :cascade do |t|
    t.text "text"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mental_model_id"
    t.bigint "user_id"
    t.index ["mental_model_id"], name: "index_paragraphs_on_mental_model_id"
    t.index ["user_id"], name: "index_paragraphs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coins"
    t.integer "points"
  end

end
