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

ActiveRecord::Schema.define(version: 2020_11_04_195629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "hourly_rate"
    t.string "company_name"
    t.string "phone"
    t.string "company_website"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "postcode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "stripe_customer_id"
    t.boolean "subscription_paid", default: false
    t.string "stripe_product_id"
    t.string "stripe_subscription_id"
    t.string "stripe_connected_account_id"
    t.string "billing_address_line_1"
    t.string "billing_address_line_2"
    t.string "billing_postcode"
    t.string "billing_city"
    t.string "billing_state"
    t.string "billing_country"
    t.boolean "active", default: true
    t.integer "billing_type"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admin_users_groups", id: false, force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.bigint "group_id", null: false
    t.index ["admin_user_id", "group_id"], name: "index_admin_users_groups_on_admin_user_id_and_group_id"
    t.index ["group_id", "admin_user_id"], name: "index_admin_users_groups_on_group_id_and_admin_user_id"
  end

  create_table "agreement_templates", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.boolean "public"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "agreements", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.string "name"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "agreement_template_id"
    t.bigint "case_id"
    t.string "pdcflow_document_id"
    t.string "pdcflow_signature_id"
    t.text "pdcflow_signature_link"
    t.string "pdcflow_verification_pin"
    t.index ["admin_user_id"], name: "index_agreements_on_admin_user_id"
    t.index ["agreement_template_id"], name: "index_agreements_on_agreement_template_id"
    t.index ["case_id"], name: "index_agreements_on_case_id", unique: true
  end

  create_table "cases", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.string "program"
    t.string "name"
    t.text "description"
    t.text "tags", default: [], array: true
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_cases_on_admin_user_id"
  end

  create_table "cases_contacts", id: false, force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "case_id", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "contact_type"
    t.string "email"
    t.string "title"
    t.string "company"
    t.string "phone"
    t.string "address"
    t.text "notes"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.text "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_contacts_on_admin_user_id"
  end

  create_table "contacts_parties", id: false, force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "party_id", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.string "file_name"
    t.text "description"
    t.date "date"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_documents_on_admin_user_id"
    t.index ["case_id"], name: "index_documents_on_case_id"
  end

  create_table "group_translations", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["group_id"], name: "index_group_translations_on_group_id"
    t.index ["locale"], name: "index_group_translations_on_locale"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups_permissions", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "permission_id", null: false
    t.index ["group_id", "permission_id"], name: "index_groups_permissions_on_group_id_and_permission_id"
    t.index ["permission_id", "group_id"], name: "index_groups_permissions_on_permission_id_and_group_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.bigint "party_id"
    t.string "name"
    t.integer "time"
    t.integer "amount"
    t.date "date"
    t.date "due_date"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_payment_intent_id"
    t.string "stripe_client_secret"
    t.text "description"
    t.index ["admin_user_id"], name: "index_invoices_on_admin_user_id"
    t.index ["case_id"], name: "index_invoices_on_case_id"
    t.index ["party_id"], name: "index_invoices_on_party_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.bigint "party_id"
    t.string "title"
    t.text "description"
    t.string "resolution_title"
    t.text "resolution_description"
    t.string "mediators_notes_title"
    t.text "mediators_notes_description"
    t.text "agreement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_issues_on_admin_user_id"
    t.index ["case_id"], name: "index_issues_on_case_id"
    t.index ["party_id"], name: "index_issues_on_party_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.bigint "party_id"
    t.string "subject"
    t.date "sent_at"
    t.text "content"
    t.string "from"
    t.string "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "read", default: false
    t.index ["admin_user_id"], name: "index_messages_on_admin_user_id"
    t.index ["case_id"], name: "index_messages_on_case_id"
    t.index ["party_id"], name: "index_messages_on_party_id"
  end

  create_table "parties", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "company"
    t.string "address"
    t.text "notes"
    t.string "email"
    t.string "phone"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.text "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pdcflow_signature_id"
    t.text "pdcflow_signature_link"
    t.string "pdcflow_verification_pin"
    t.string "pdcflow_status"
    t.index ["admin_user_id"], name: "index_parties_on_admin_user_id"
    t.index ["case_id"], name: "index_parties_on_case_id"
  end

  create_table "permission_translations", force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "description"
    t.index ["locale"], name: "index_permission_translations_on_locale"
    t.index ["permission_id"], name: "index_permission_translations_on_permission_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "key"
  end

  create_table "reminders", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.bigint "party_id"
    t.string "name"
    t.text "description"
    t.integer "priority"
    t.date "due_date"
    t.bigint "contact_id"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_reminders_on_admin_user_id"
    t.index ["case_id"], name: "index_reminders_on_case_id"
    t.index ["contact_id"], name: "index_reminders_on_contact_id"
    t.index ["party_id"], name: "index_reminders_on_party_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "case_id"
    t.bigint "party_id"
    t.string "name"
    t.date "due_date"
    t.time "time_start"
    t.time "time_finish"
    t.integer "session_type"
    t.string "location"
    t.text "tags", default: [], array: true
    t.integer "rate_type"
    t.integer "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_sessions_on_admin_user_id"
    t.index ["case_id"], name: "index_sessions_on_case_id"
    t.index ["party_id"], name: "index_sessions_on_party_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agreements", "agreement_templates"
end
