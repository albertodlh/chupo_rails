# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141228234642) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.text     "content",    default: "", null: false
    t.datetime "pubdate"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "tag",        default: "", null: false
  end

  add_index "articles", ["pubdate"], name: "index_articles_on_pubdate"
  add_index "articles", ["title"], name: "index_articles_on_title"

  create_table "comments", force: :cascade do |t|
    t.string   "user",       default: "Chupo", null: false
    t.string   "email",      default: "",      null: false
    t.string   "website",    default: "",      null: false
    t.text     "content",    default: "",      null: false
    t.datetime "pubdate"
    t.string   "status",     default: "P",     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "gravatar",   default: "",      null: false
  end

  add_index "comments", ["email"], name: "index_comments_on_email"
  add_index "comments", ["user"], name: "index_comments_on_user"

  create_table "videos", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.string   "youtube_id", default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
