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

ActiveRecord::Schema.define(version: 20171001135234) do

  create_table "cancellations", force: :cascade do |t|
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "exp_email"
    t.string "exp_name"
    t.text "exp_desc"
    t.text "exp_provide"
    t.text "exp_notes"
    t.text "exp_location"
    t.text "about_me"
    t.text "guest_reqs"
    t.integer "max_guest"
    t.integer "rsv_guest"
    t.integer "min_guest"
    t.integer "can_policy"
    t.integer "ratings"
    t.integer "exp_price"
    t.datetime "start_time"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "user_id"
    t.string "slug"
    t.time "exp_duration"
    t.float "latitude"
    t.float "longitude"
    t.text "exp_where_be"
    t.boolean "active"
    t.date "start_date"
    t.time "go_time"
    t.index ["slug"], name: "index_experiences_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "exp_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience_id"
    t.index ["experience_id"], name: "index_guests_on_experience_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "context"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payoffs", force: :cascade do |t|
    t.integer "user_id"
    t.string "custom_stripe_id"
    t.string "country"
    t.string "type"
    t.integer "dob_day"
    t.integer "dob_month"
    t.integer "dob_year"
    t.string "gender"
    t.string "phone_no"
    t.string "first_name_kana"
    t.string "first_name_kanji"
    t.string "last_name_kana"
    t.string "last_name_kanji"
    t.string "business_name_kana"
    t.string "business_name_kanji"
    t.string "address_line1_kana"
    t.string "address_line1_kanji"
    t.string "address_line2_kana"
    t.string "address_line2_kanji"
    t.string "state_kana"
    t.string "state_kanji"
    t.string "city_kana"
    t.string "city_kanji"
    t.string "town_kana"
    t.string "town_kanji"
    t.string "postal_code"
    t.string "bank_name"
    t.string "branch_name"
    t.string "account_name_kana"
    t.string "account_name_english"
    t.string "account_no"
    t.string "swift"
    t.string "bank_code"
    t.string "branch_code"
    t.integer "account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payoffs_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "experience_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["experience_id"], name: "index_photos_on_experience_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "experience_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "price"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_reservations_on_experience_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "user_email"
    t.integer "rating", default: 1
    t.text "rating_desc"
    t.datetime "review_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience_id"
    t.integer "user_id"
    t.index ["experience_id"], name: "index_reviews_on_experience_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "buyer_email"
    t.string "seller_email"
    t.integer "amount"
    t.string "currency"
    t.string "uuid"
    t.integer "exp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience_id"
    t.string "state"
    t.string "stripe_token"
    t.text "error"
    t.string "stripe_id"
    t.integer "booked_qty"
    t.date "start_date"
    t.boolean "notified", default: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "user_id"
    t.integer "experience_id"
    t.datetime "start_date"
    t.integer "no_guests", default: 0
    t.integer "max_guests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_schedules_on_experience_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.boolean "enable_sms", default: true
    t.boolean "enable_email", default: true
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "contact_no"
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "name"
    t.string "profile_pic"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "publishable_key"
    t.string "access_code"
    t.string "pin"
    t.boolean "phone_verified"
    t.text "description"
    t.integer "unread", default: 0
    t.string "profile_pic_file_name"
    t.string "profile_pic_content_type"
    t.integer "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string "social_provider"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
