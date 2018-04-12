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

ActiveRecord::Schema.define(version: 20180412000710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.decimal "amount", precision: 16, scale: 3
    t.bigint "donator_id"
    t.bigint "scenario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donator_id"], name: "index_donations_on_donator_id"
    t.index ["scenario_id"], name: "index_donations_on_scenario_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location_name"
  end

  create_table "interaction_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nouns", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint "scenario_id"
    t.bigint "verifier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["scenario_id"], name: "index_proofs_on_scenario_id"
    t.index ["verifier_id"], name: "index_proofs_on_verifier_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.bigint "verb_id"
    t.bigint "noun_id"
    t.bigint "requester_id"
    t.bigint "doer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.decimal "funding_goal", precision: 16, scale: 3
    t.bigint "event_id"
    t.bigint "parent_scenario_id"
    t.string "custom_message"
    t.index ["doer_id"], name: "index_scenarios_on_doer_id"
    t.index ["event_id"], name: "index_scenarios_on_event_id"
    t.index ["noun_id"], name: "index_scenarios_on_noun_id"
    t.index ["parent_scenario_id"], name: "index_scenarios_on_parent_scenario_id"
    t.index ["requester_id"], name: "index_scenarios_on_requester_id"
    t.index ["verb_id"], name: "index_scenarios_on_verb_id"
  end

  create_table "user_ad_interactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "interaction_type_id"
    t.bigint "ad_type_id"
    t.bigint "scenario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_type_id"], name: "index_user_ad_interactions_on_ad_type_id"
    t.index ["interaction_type_id"], name: "index_user_ad_interactions_on_interaction_type_id"
    t.index ["scenario_id"], name: "index_user_ad_interactions_on_scenario_id"
    t.index ["user_id"], name: "index_user_ad_interactions_on_user_id"
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
    t.float "longitude"
    t.float "latitude"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verbs", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "donations", "scenarios"
  add_foreign_key "donations", "users", column: "donator_id"
  add_foreign_key "proofs", "scenarios"
  add_foreign_key "proofs", "users", column: "verifier_id"
  add_foreign_key "scenarios", "events"
  add_foreign_key "scenarios", "nouns"
  add_foreign_key "scenarios", "scenarios", column: "parent_scenario_id"
  add_foreign_key "scenarios", "users", column: "doer_id"
  add_foreign_key "scenarios", "users", column: "requester_id"
  add_foreign_key "scenarios", "verbs"
  add_foreign_key "user_ad_interactions", "ad_types"
  add_foreign_key "user_ad_interactions", "interaction_types"
  add_foreign_key "user_ad_interactions", "scenarios"
  add_foreign_key "user_ad_interactions", "users"
end
