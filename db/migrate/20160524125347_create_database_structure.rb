class CreateDatabaseStructure < ActiveRecord::Migration
  def change
    create_table "body_types", force: true do |t|
      t.string   "name"
      t.string   "icon"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "brands", force: true do |t|
      t.string   "slug"
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "brands", ["slug"], name: "index_brands_on_slug", unique: true, using: :btree

    create_table "car_media", force: true do |t|
      t.integer  "car_id"
      t.string   "file"
      t.string   "file_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "avatar_processing", default: false, null: false
    end

    add_index "car_media", ["car_id"], name: "index_car_media_on_car_id", using: :btree

    create_table "cars", force: true do |t|
      t.string   "slug"
      t.string   "vehicle_number"
      t.string   "vehicle_number_hexon"
      t.integer  "model_id"
      t.integer  "brand_id"
      t.integer  "transmission_type_id"
      t.integer  "body_type_id"
      t.integer  "fuel_type_id"
      t.integer  "mileage"
      t.string   "color"
      t.string   "color_type"
      t.string   "engine_size"
      t.string   "car_type"
      t.boolean  "nap"
      t.boolean  "rdw"
      t.integer  "price_total"
      t.integer  "price_month"
      t.integer  "price_50_50"
      t.integer  "manufacture_year"
      t.integer  "cylinders"
      t.integer  "engine_power"
      t.integer  "top_speed"
      t.string   "interior"
      t.string   "energy_label"
      t.string   "road_tax"
      t.string   "reserved"
      t.string   "new"
      t.string   "btw_marge"
      t.string   "door_count"
      t.string   "license_plate"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree
    add_index "cars", ["model_id"], name: "index_cars_on_model_id", using: :btree
    add_index "cars", ["price_50_50"], name: "index_cars_on_price_50_50", using: :btree
    add_index "cars", ["price_month"], name: "index_cars_on_price_month", using: :btree
    add_index "cars", ["price_total"], name: "index_cars_on_price_total", using: :btree
    add_index "cars", ["slug"], name: "index_cars_on_slug", unique: true, using: :btree
    add_index "cars", ["transmission_type_id"], name: "index_cars_on_transmission_type_id", using: :btree
    add_index "cars", ["vehicle_number", "vehicle_number_hexon"], name: "index_cars_on_vehicle_number_and_vehicle_number_hexon", unique: true, using: :btree

    create_table "fuel_types", force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "models", force: true do |t|
      t.integer  "brand_id"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
    end

    add_index "models", ["slug"], name: "index_models_on_slug", unique: true, using: :btree

    create_table "transmission_types", force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end
