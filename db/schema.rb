# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_05_233633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcasts", force: :cascade do |t|
    t.text "tags", default: [], array: true
    t.datetime "send_at"
    t.text "markdown_body"
    t.string "subject"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "sent_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "description_markdown"
    t.string "primary_email", null: false
    t.text "secondary_emails", default: [], array: true
    t.string "phone"
    t.datetime "last_proactive_outreach"
    t.datetime "last_inbound_message"
    t.string "linkedin"
    t.string "twitter"
    t.string "instagram"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "tags", default: [], array: true
    t.string "unsubscribe_key"
    t.datetime "unsubscribed_at"
    t.datetime "subscribed_at"
  end

  create_table "failed_downloads", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "marked_ignore"
  end

  create_table "succesful_downloads", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "had_towers"
    t.boolean "had_transmitters"
  end

  create_table "towers", force: :cascade do |t|
    t.string "tower_type"
    t.string "faa_study_number"
    t.string "registration_number"
    t.string "latitude"
    t.string "longitude"
    t.string "status_code"
    t.string "date_constructed"
    t.string "structure_street_address"
    t.string "structure_city"
    t.string "structure_state_code"
    t.string "height_of_structure"
    t.string "ground_elevation"
    t.string "overall_height_above_ground"
    t.string "overall_height_amsl"
    t.string "structure_type"
    t.string "owner_entity_name"
    t.string "owner_licensee_id"
    t.string "owner_first_name"
    t.string "owner_last_name"
    t.string "owner_phone"
    t.string "owner_internet_address"
    t.string "owner_street_address"
    t.string "owner_po_box"
    t.string "owner_city"
    t.string "owner_state"
    t.string "owner_zip_code"
    t.string "owner_attention"
    t.string "rep_entity_name"
    t.string "rep_licensee_id"
    t.string "rep_first_name"
    t.string "rep_last_name"
    t.string "rep_phone"
    t.string "rep_internet_address"
    t.string "rep_street_address"
    t.string "rep_po_box"
    t.string "rep_city"
    t.string "rep_state"
    t.string "rep_zip_code"
    t.string "rep_attention"
    t.string "hist1_purpose"
    t.string "hist1_status"
    t.string "hist1_date"
    t.string "hist1_addnl"
    t.string "hist2_purpose"
    t.string "hist2_status"
    t.string "hist2_date"
    t.string "hist2_addnl"
    t.string "hist3_purpose"
    t.string "hist3_status"
    t.string "hist3_date"
    t.string "hist3_addnl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["latitude"], name: "index_towers_on_latitude"
    t.index ["longitude"], name: "index_towers_on_longitude"
  end

  create_table "transmitters", force: :cascade do |t|
    t.string "sitetype"
    t.string "sitenum"
    t.string "latitude"
    t.string "longitude"
    t.string "call_sign"
    t.string "location_address"
    t.string "location_city"
    t.string "location_county"
    t.string "location_state"
    t.string "ground_elevation"
    t.string "height_of_support_structure"
    t.string "overall_height_of_structure"
    t.string "structure_type"
    t.string "licensee_entity_name"
    t.string "licensee_first_name"
    t.string "licensee_last_name"
    t.string "licensee_phone"
    t.string "licensee_fax"
    t.string "licensee_email"
    t.string "licensee_street_address"
    t.string "licensee_city"
    t.string "licensee_state"
    t.string "licensee_zip_code"
    t.string "licensee_po_box"
    t.string "licensee_attention_line"
    t.string "contact_entity_name"
    t.string "contact_first_name"
    t.string "contact_last_name"
    t.string "contact_phone"
    t.string "contact_fax"
    t.string "contact_email"
    t.string "contact_street_address"
    t.string "contact_city"
    t.string "contact_state"
    t.string "contact_zip_code"
    t.string "contact_po_box"
    t.string "contact_attention_line"
    t.string "emmitter_1_freqs_mhz"
    t.string "emmitter_2_freqs_mhz"
    t.string "emmitter_3_freqs_mhz"
    t.string "emmitter_4_freqs_mhz"
    t.string "emmitter_5_freqs_mhz"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["latitude"], name: "index_transmitters_on_latitude"
    t.index ["longitude"], name: "index_transmitters_on_longitude"
  end

end
