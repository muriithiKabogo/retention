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

ActiveRecord::Schema.define(version: 20171128201018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_key", id: :serial, force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "read_key", limit: 255, null: false
    t.string "write_key", limit: 255, null: false
    t.string "master_key", limit: 255, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
  end

  create_table "config", primary_key: ["project", "name"], force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.text "value"
  end

  create_table "continuous_query_metadata", primary_key: ["project", "table_name"], force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "table_name", limit: 255, null: false
    t.text "query", null: false
    t.text "partition_keys"
    t.text "options"
  end

  create_table "custom_data_source", primary_key: ["project", "schema_name"], force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "schema_name", limit: 255, null: false
    t.text "type", null: false
    t.text "options"
  end

  create_table "custom_file_source", primary_key: ["project", "table_name"], force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "table_name", limit: 255, null: false
    t.text "options"
  end

  create_table "javascript_logs", id: false, force: :cascade do |t|
    t.text "id", null: false
    t.string "project", limit: 255, null: false
    t.string "type", limit: 15, null: false
    t.string "prefix", limit: 255, null: false
    t.text "error", null: false
    t.bigint "created", default: 0, null: false
  end

  create_table "materialized_views", primary_key: ["project", "table_name"], force: :cascade do |t|
    t.string "project", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "table_name", limit: 255, null: false
    t.text "query", null: false
    t.bigint "update_interval"
    t.bigint "last_updated"
    t.boolean "incremental"
    t.text "options"
    t.boolean "real_time", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
