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

ActiveRecord::Schema.define(version: 20170806195354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_blocks", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "block_slot_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.integer "block_record_version"
    t.string "block_record_type"
    t.bigint "block_record_id"
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.jsonb "blocks"
    t.datetime "created_at"
    t.index ["block_record_id"], name: "index_block_slot_versions_on_block_record_id"
    t.index ["block_record_type", "block_record_id"], name: "index_block_slot_version_on_block_record"
    t.index ["block_record_version"], name: "index_block_slot_versions_on_block_record_version"
    t.index ["blocks"], name: "index_block_slot_versions_on_blocks", using: :gin
    t.index ["item_type", "item_id"], name: "index_block_slot_versions_on_item_type_and_item_id"
  end

  create_table "block_slots", id: :serial, force: :cascade do |t|
    t.integer "block_id"
    t.string "layout"
    t.string "block_type", null: false
    t.string "block_record_type"
    t.integer "block_record_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id", "block_type"], name: "index_block_slots_on_block_id_and_block_type"
    t.index ["block_record_type", "block_record_id"], name: "index_block_slots_on_block_record_type_and_block_record_id"
    t.index ["block_type", "block_id"], name: "index_block_slots_on_block_type_and_block_id"
    t.index ["layout"], name: "index_block_slots_on_layout"
  end

  create_table "block_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_block_types_on_name", unique: true
  end

  create_table "block_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.integer "block_record_version"
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.datetime "created_at"
    t.index ["block_record_version"], name: "index_block_versions_on_block_record_version"
    t.index ["item_type", "item_id"], name: "index_block_versions_on_item_type_and_item_id"
  end

  create_table "image_blocks", id: :serial, force: :cascade do |t|
    t.integer "image_id"
    t.text "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_items", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "caption"
    t.string "alternative_text"
    t.text "description"
    t.text "dimensions"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string "attachable_type"
    t.integer "attachable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_media_items_on_attachable_type_and_attachable_id"
    t.index ["slug"], name: "index_media_items_on_slug", unique: true
  end

  create_table "menus", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "structure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_menus_on_slug", unique: true
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "path"
    t.integer "status", default: 1, null: false
    t.datetime "scheduled_date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "featured_image_id"
    t.integer "parent_page_id"
    t.index ["featured_image_id"], name: "index_pages_on_featured_image_id"
    t.index ["parent_page_id"], name: "index_pages_on_parent_page_id"
    t.index ["path"], name: "index_pages_on_path", unique: true
    t.index ["slug"], name: "index_pages_on_slug"
    t.index ["status"], name: "index_pages_on_status"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "value"
    t.text "description"
    t.string "value_type", default: "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_settings_on_slug", unique: true
  end

  create_table "text_blocks", id: :serial, force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "title_blocks", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_groups_on_name", unique: true
  end

  create_table "user_groups_users", id: false, force: :cascade do |t|
    t.bigint "user_group_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_group_id", "user_id"], name: "index_user_groups_users_on_user_group_id_and_user_id"
    t.index ["user_id", "user_group_id"], name: "index_user_groups_users_on_user_id_and_user_group_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.text "settings", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.jsonb "block_slots"
    t.datetime "created_at"
    t.index ["block_slots"], name: "index_versions_on_block_slots", using: :gin
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
