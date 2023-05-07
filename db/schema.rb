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

ActiveRecord::Schema[7.0].define(version: 2023_05_07_095919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "listing_condition", ["mint", "near_mint", "used", "defective"]

  create_table "app_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_sessions_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.bigint "organization_id", null: false
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "condition", enum_type: "listing_condition"
    t.index ["creator_id"], name: "index_listings_on_creator_id"
    t.index ["organization_id"], name: "index_listings_on_organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "app_sessions", "users"
  add_foreign_key "listings", "organizations"
  add_foreign_key "listings", "users", column: "creator_id"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
end
