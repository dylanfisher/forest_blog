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

ActiveRecord::Schema.define(version: 20180808204536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_blocks", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "block_kinds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_block_kinds_on_category"
    t.index ["name"], name: "index_block_kinds_on_name", unique: true
  end

  create_table "block_layouts", force: :cascade do |t|
    t.string "slug"
    t.string "display_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_block_layouts_on_slug", unique: true
  end

  create_table "block_slots", id: :serial, force: :cascade do |t|
    t.string "block_type"
    t.integer "block_id"
    t.integer "block_kind_id"
    t.string "block_record_type"
    t.integer "block_record_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "block_layout_id"
    t.index ["block_kind_id"], name: "index_block_slots_on_block_kind_id"
    t.index ["block_layout_id"], name: "index_block_slots_on_block_layout_id"
    t.index ["block_record_type", "block_record_id"], name: "index_block_slots_on_block_record_type_and_block_record_id"
    t.index ["block_type", "block_id"], name: "index_block_slots_on_block_type_and_block_id"
  end

  create_table "cache_records", id: :serial, force: :cascade do |t|
    t.integer "cacheable_id"
    t.string "cacheable_type"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cacheable_type", "cacheable_id"], name: "index_cache_records_on_type_and_id"
  end

  create_table "image_blocks", force: :cascade do |t|
    t.bigint "media_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_item_id"], name: "index_image_blocks_on_media_item_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "media_item_status", default: 0
    t.index ["attachment_content_type"], name: "index_media_items_on_attachment_content_type"
    t.index ["created_at"], name: "index_media_items_on_created_at"
    t.index ["media_item_status"], name: "index_media_items_on_media_item_status"
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
    t.string "redirect"
    t.jsonb "blockable_metadata", default: {}
    t.index ["blockable_metadata"], name: "index_pages_on_blockable_metadata", using: :gin
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

  create_table "text_blocks", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "title_blocks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.string "key", null: false
    t.text "value", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_translations_on_key", unique: true
  end

  create_table "user_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_groups_on_name", unique: true
  end

  create_table "user_groups_users", id: false, force: :cascade do |t|
    t.integer "user_group_id", null: false
    t.integer "user_id", null: false
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

  add_foreign_key "block_slots", "block_kinds"
  add_foreign_key "block_slots", "block_layouts"
  add_foreign_key "image_blocks", "media_items"
end
