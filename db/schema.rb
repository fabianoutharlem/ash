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

ActiveRecord::Schema.define(version: 20160713172353) do

  create_table "alternatives", force: :cascade do |t|
    t.string   "which",        limit: 255
    t.integer  "participants", limit: 4,     default: 0
    t.integer  "conversions",  limit: 4,     default: 0
    t.text     "experiment",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alternatives", ["which"], name: "index_alternatives_on_which", using: :btree

  create_table "body_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "icon",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", force: :cascade do |t|
    t.string   "slug",            limit: 255
    t.boolean  "visible_in_menu",               default: false
    t.string   "name",            limit: 255
    t.string   "image",           limit: 255
    t.text     "description",     limit: 65535
    t.integer  "row_order",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["slug"], name: "index_brands_on_slug", unique: true, using: :btree

  create_table "car_media", force: :cascade do |t|
    t.integer  "car_id",            limit: 4
    t.string   "file",              limit: 255
    t.string   "file_type",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "avatar_processing",             default: false, null: false
  end

  add_index "car_media", ["car_id"], name: "index_car_media_on_car_id", using: :btree

  create_table "cars", force: :cascade do |t|
    t.string   "slug",                 limit: 255
    t.string   "vehicle_number",       limit: 255
    t.string   "vehicle_number_hexon", limit: 255
    t.integer  "model_id",             limit: 4
    t.integer  "brand_id",             limit: 4
    t.integer  "transmission_type_id", limit: 4
    t.integer  "body_type_id",         limit: 4
    t.integer  "fuel_type_id",         limit: 4
    t.integer  "mileage",              limit: 4
    t.string   "color",                limit: 255
    t.string   "color_type",           limit: 255
    t.string   "engine_size",          limit: 255
    t.string   "car_type",             limit: 255
    t.boolean  "nap"
    t.boolean  "rdw"
    t.integer  "price_total",          limit: 4
    t.decimal  "price_discount",                   precision: 10
    t.integer  "price_month",          limit: 4
    t.integer  "price_50_50",          limit: 4
    t.integer  "manufacture_year",     limit: 4
    t.integer  "cylinders",            limit: 4
    t.integer  "engine_power",         limit: 4
    t.integer  "top_speed",            limit: 4
    t.string   "interior",             limit: 255
    t.string   "energy_label",         limit: 255
    t.string   "road_tax",             limit: 255
    t.string   "reserved",             limit: 255
    t.string   "new",                  limit: 255
    t.string   "btw_marge",            limit: 255
    t.string   "door_count",           limit: 255
    t.string   "license_plate",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "best_day_deal",                                   default: false
    t.integer  "views",                limit: 4
  end

  add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree
  add_index "cars", ["model_id"], name: "index_cars_on_model_id", using: :btree
  add_index "cars", ["price_50_50"], name: "index_cars_on_price_50_50", using: :btree
  add_index "cars", ["price_month"], name: "index_cars_on_price_month", using: :btree
  add_index "cars", ["price_total"], name: "index_cars_on_price_total", using: :btree
  add_index "cars", ["slug"], name: "index_cars_on_slug", unique: true, using: :btree
  add_index "cars", ["transmission_type_id"], name: "index_cars_on_transmission_type_id", using: :btree
  add_index "cars", ["vehicle_number", "vehicle_number_hexon"], name: "index_cars_on_vehicle_number_and_vehicle_number_hexon", unique: true, using: :btree

  create_table "fuel_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_partners", force: :cascade do |t|
    t.text     "link",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "marquee_items", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "link",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "menu_id",            limit: 4
    t.integer  "menu_itemable_id",   limit: 4
    t.string   "menu_itemable_type", limit: 255
    t.integer  "row_order",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "location",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "models", force: :cascade do |t|
    t.integer  "brand_id",   limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
  end

  add_index "models", ["slug"], name: "index_models_on_slug", unique: true, using: :btree

  create_table "newsletter_template_values", force: :cascade do |t|
    t.string   "option_name",            limit: 255
    t.string   "option_type",            limit: 255
    t.integer  "newsletter_template_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "newsletter_template_values", ["newsletter_template_id"], name: "index_newsletter_template_values_on_newsletter_template_id", using: :btree

  create_table "newsletter_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "template",   limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "newsletter_values", force: :cascade do |t|
    t.integer  "newsletter_id",                limit: 4
    t.integer  "newsletter_template_value_id", limit: 4
    t.string   "value",                        limit: 255
    t.string   "type",                         limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "newsletter_values", ["newsletter_id"], name: "index_newsletter_values_on_newsletter_id", using: :btree
  add_index "newsletter_values", ["newsletter_template_value_id"], name: "index_newsletter_values_on_newsletter_template_value_id", using: :btree

  create_table "newsletters", force: :cascade do |t|
    t.string   "campaign_id",            limit: 255
    t.string   "title",                  limit: 255
    t.string   "subject",                limit: 255
    t.integer  "newsletter_template_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "newsletters", ["newsletter_template_id"], name: "index_newsletters_on_newsletter_template_id", using: :btree

  create_table "page_template_values", force: :cascade do |t|
    t.string   "option_name",      limit: 255
    t.string   "option_type",      limit: 255
    t.string   "context",          limit: 255
    t.integer  "page_template_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_template_values", ["page_template_id"], name: "index_page_template_values_on_page_template_id", using: :btree

  create_table "page_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "template",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_values", force: :cascade do |t|
    t.integer  "page_id",                limit: 4
    t.integer  "page_template_value_id", limit: 4
    t.text     "value",                  limit: 65535
    t.string   "type",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_values", ["page_id"], name: "index_page_values_on_page_id", using: :btree
  add_index "page_values", ["page_template_value_id"], name: "index_page_values_on_page_template_value_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "slug",             limit: 255
    t.integer  "page_template_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phrasing_phrase_versions", force: :cascade do |t|
    t.integer  "phrasing_phrase_id", limit: 4
    t.text     "value",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phrasing_phrase_versions", ["phrasing_phrase_id"], name: "index_phrasing_phrase_versions_on_phrasing_phrase_id", using: :btree

  create_table "phrasing_phrases", force: :cascade do |t|
    t.string   "locale",     limit: 255
    t.string   "key",        limit: 255
    t.text     "value",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "review",     limit: 65535
    t.integer  "rating",     limit: 4
    t.boolean  "approved",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "slide_template_values", force: :cascade do |t|
    t.string   "option_name",       limit: 255
    t.string   "option_type",       limit: 255
    t.integer  "slide_template_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "slide_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "template",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slide_values", force: :cascade do |t|
    t.integer  "slide_id",                limit: 4
    t.integer  "slide_template_value_id", limit: 4
    t.string   "value",                   limit: 255
    t.string   "type",                    limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "sliders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "location",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slides", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "row_order",         limit: 4
    t.integer  "slider_id",         limit: 4
    t.integer  "slide_template_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "slides", ["slider_id"], name: "index_slides_on_slider_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "transmission_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "slug",        limit: 255
    t.string   "sub_title",   limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "menu_items", "menus"
  add_foreign_key "newsletter_template_values", "newsletter_templates"
  add_foreign_key "newsletter_values", "newsletter_template_values"
  add_foreign_key "newsletter_values", "newsletters"
  add_foreign_key "newsletters", "newsletter_templates"
  add_foreign_key "page_template_values", "page_templates"
  add_foreign_key "page_values", "page_template_values"
  add_foreign_key "page_values", "pages"
  add_foreign_key "slides", "sliders"
end
