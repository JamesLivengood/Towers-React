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

ActiveRecord::Schema.define(version: 2019_10_17_010112) do

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

end
