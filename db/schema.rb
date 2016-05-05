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

ActiveRecord::Schema.define(version: 20160505001630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "blacklistings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "blocked_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "blacklistings", ["user_id", "blocked_user_id"], name: "index_blacklistings_on_user_id_and_blocked_user_id", unique: true, using: :btree

  create_table "exchanges", force: :cascade do |t|
    t.integer  "provider_id",                 null: false
    t.integer  "seeker_id",                   null: false
    t.boolean  "s_accepted",  default: false, null: false
    t.boolean  "p_accepted",  default: false, null: false
    t.boolean  "s_finished",  default: false, null: false
    t.boolean  "p_finished",  default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "privacy_profiles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "public_comments"
    t.text     "private_comments"
    t.integer  "rating"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "author_id"
    t.integer  "exchange_id"
  end

  add_index "reviews", ["exchange_id", "author_id", "user_id"], name: "index_reviews_on_exchange_id_and_author_id_and_user_id", unique: true, using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string    "email",                                                                           default: "",    null: false
    t.string    "encrypted_password",                                                              default: "",    null: false
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                                                                   default: 0,     null: false
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.inet      "current_sign_in_ip"
    t.inet      "last_sign_in_ip"
    t.string    "confirmation_token"
    t.datetime  "confirmed_at"
    t.datetime  "confirmation_sent_at"
    t.string    "unconfirmed_email"
    t.integer   "failed_attempts",                                                                 default: 0,     null: false
    t.string    "unlock_token"
    t.datetime  "locked_at"
    t.datetime  "created_at",                                                                                      null: false
    t.datetime  "updated_at",                                                                                      null: false
    t.text      "name"
    t.text      "gender"
    t.date      "birthday"
    t.text      "about"
    t.boolean   "provider"
    t.geography "lonlat",                 limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string    "zipcode"
    t.float     "longitude"
    t.float     "latitude"
    t.boolean   "food",                                                                            default: false, null: false
    t.boolean   "shelter",                                                                         default: false, null: false
    t.boolean   "transport",                                                                       default: false, null: false
    t.boolean   "shower",                                                                          default: false, null: false
    t.boolean   "laundry",                                                                         default: false, null: false
    t.boolean   "buddy",                                                                           default: false, null: false
    t.boolean   "misc",                                                                            default: false, null: false
    t.text      "food_info"
    t.text      "shelter_info"
    t.text      "transport_info"
    t.text      "shower_info"
    t.text      "laundry_info"
    t.text      "buddy_info"
    t.text      "misc_info"
    t.boolean   "shelter_accessible",                                                              default: false, null: false
    t.boolean   "shelter_pets",                                                                    default: false, null: false
    t.string    "city"
    t.string    "state"
    t.string    "country"
    t.string    "tagline"
    t.integer   "privacy_email"
    t.integer   "privacy_location"
    t.integer   "privacy_activity"
    t.integer   "privacy_gender"
    t.integer   "privacy_age"
    t.integer   "privacy_about"
    t.integer   "privacy_resources"
    t.integer   "privacy_resources_info"
    t.integer   "privacy_exchanges"
    t.integer   "privacy_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["lonlat"], name: "index_users_on_lonlat", using: :gist
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "blacklistings", "users"
  add_foreign_key "blacklistings", "users", column: "blocked_user_id"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "privacy_profiles", "users"
  add_foreign_key "reviews", "exchanges"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "users", column: "author_id"
end
