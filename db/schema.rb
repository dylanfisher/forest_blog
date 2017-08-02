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

ActiveRecord::Schema.define(version: 20170802044856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.string "slug"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_artists_on_slug", unique: true
    t.index ["status"], name: "index_artists_on_status"
  end

  create_table "artists_artworks", id: false, force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "artwork_id", null: false
    t.index ["artist_id", "artwork_id"], name: "index_artists_artworks_on_artist_id_and_artwork_id"
    t.index ["artwork_id", "artist_id"], name: "index_artists_artworks_on_artwork_id_and_artist_id"
  end

  create_table "artists_exhibitions", id: false, force: :cascade do |t|
    t.bigint "exhibition_id", null: false
    t.bigint "artist_id", null: false
    t.index ["artist_id", "exhibition_id"], name: "index_artists_exhibitions_on_artist_id_and_exhibition_id"
    t.index ["exhibition_id", "artist_id"], name: "index_artists_exhibitions_on_exhibition_id_and_artist_id"
  end

  create_table "artworks", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date"
    t.string "slug"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "featured_image_id"
    t.index ["featured_image_id"], name: "index_artworks_on_featured_image_id"
    t.index ["slug"], name: "index_artworks_on_slug", unique: true
    t.index ["status"], name: "index_artworks_on_status"
  end

  create_table "artworks_exhibitions", id: false, force: :cascade do |t|
    t.bigint "exhibition_id", null: false
    t.bigint "artwork_id", null: false
    t.index ["artwork_id", "exhibition_id"], name: "index_artworks_exhibitions_on_artwork_id_and_exhibition_id"
    t.index ["exhibition_id", "artwork_id"], name: "index_artworks_exhibitions_on_exhibition_id_and_artwork_id"
  end

  create_table "base_blocks", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "block_records", id: :serial, force: :cascade do |t|
    t.string "block_record_type"
    t.integer "block_record_id"
    t.text "slot_cache"
    t.text "block_cache"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_record_id", "block_record_type"], name: "index_block_records_on_block_record_id_and_block_record_type"
    t.index ["block_record_type", "block_record_id"], name: "index_block_records_on_block_record_type_and_block_record_id"
  end

  create_table "block_slots", id: :serial, force: :cascade do |t|
    t.integer "page_id"
    t.integer "page_version_id"
    t.integer "block_id"
    t.string "block_type"
    t.integer "block_version_id"
    t.text "block_slot_cache"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "block_record_type"
    t.integer "block_record_id"
    t.string "layout"
    t.index ["block_id", "block_type"], name: "index_block_slots_on_block_id_and_block_type"
    t.index ["block_record_id", "block_record_type"], name: "index_block_slots_on_block_record_id_and_block_record_type"
    t.index ["block_record_type", "block_record_id"], name: "index_block_slots_on_block_record_type_and_block_record_id"
    t.index ["block_type", "block_id"], name: "index_block_slots_on_block_type_and_block_id"
    t.index ["block_type", "block_version_id"], name: "index_block_slots_on_block_type_and_block_version_id"
    t.index ["block_version_id", "block_type"], name: "index_block_slots_on_block_version_id_and_block_type"
    t.index ["layout"], name: "index_block_slots_on_layout"
    t.index ["page_id"], name: "index_block_slots_on_page_id"
    t.index ["page_version_id"], name: "index_block_slots_on_page_version_id"
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
    t.integer "block_record_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "block_record_version_id"
    t.string "block_record_type"
    t.index ["block_record_id"], name: "index_block_versions_on_block_record_id"
    t.index ["block_record_type"], name: "index_block_versions_on_block_record_type"
    t.index ["block_record_version_id"], name: "index_block_versions_on_block_record_version_id"
    t.index ["item_type", "item_id"], name: "index_block_versions_on_item_type_and_item_id"
  end

  create_table "exhibitions", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.string "slug"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_exhibitions_on_slug", unique: true
    t.index ["status"], name: "index_exhibitions_on_status"
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
    t.text "description"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "featured_image_id"
    t.integer "parent_page_id"
    t.text "path"
    t.datetime "scheduled_date"
    t.index ["featured_image_id"], name: "index_pages_on_featured_image_id"
    t.index ["parent_page_id"], name: "index_pages_on_parent_page_id"
    t.index ["path"], name: "index_pages_on_path", unique: true
    t.index ["slug", "parent_page_id"], name: "index_pages_on_slug_and_parent_page_id"
    t.index ["slug"], name: "index_pages_on_slug"
    t.index ["status"], name: "index_pages_on_status"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "value"
    t.string "value_type", default: "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
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
    t.text "object"
    t.datetime "created_at"
    t.integer "status"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["status"], name: "index_versions_on_status"
  end

end
