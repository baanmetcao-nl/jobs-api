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

ActiveRecord::Schema[7.0].define(version: 2023_01_29_151454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "benefits", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.integer "min_salary", null: false
    t.integer "max_salary", null: false
    t.integer "vacation_days", null: false
    t.boolean "pension", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_benefits_on_job_id"
    t.check_constraint "max_salary <= 9999999"
    t.check_constraint "max_salary >= 10000"
    t.check_constraint "max_salary >= min_salary"
    t.check_constraint "min_salary <= 9999999"
    t.check_constraint "min_salary >= 10000"
    t.check_constraint "vacation_days <= 200"
    t.check_constraint "vacation_days >= 15"
  end

  create_table "companies", force: :cascade do |t|
    t.text "name", null: false
    t.text "location", null: false
    t.text "website_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name"
    t.check_constraint "char_length(location) <= 50"
    t.check_constraint "char_length(location) >= 5"
    t.check_constraint "char_length(name) <= 50"
    t.check_constraint "char_length(name) >= 2"
  end

  create_table "email_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "email", null: false
  end

  create_table "employers", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employers_on_company_id"
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "employer_id", null: false
    t.text "position", null: false
    t.text "description", null: false
    t.integer "experience", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "published_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_jobs_on_description"
    t.index ["employer_id"], name: "index_jobs_on_employer_id"
    t.index ["experience"], name: "index_jobs_on_experience"
    t.index ["expires_at"], name: "index_jobs_on_expires_at"
    t.index ["position"], name: "index_jobs_on_position"
    t.index ["published_at"], name: "index_jobs_on_published_at"
    t.index ["status"], name: "index_jobs_on_status"
    t.check_constraint "char_length(\"position\") <= 50"
    t.check_constraint "char_length(\"position\") >= 3"
    t.check_constraint "char_length(description) <= 5000"
    t.check_constraint "char_length(description) >= 100"
    t.check_constraint "experience <= 3"
    t.check_constraint "experience >= 0"
  end

  create_table "user_email_addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "email_address_id", null: false
    t.integer "use", default: 0, null: false
    t.index ["email_address_id"], name: "index_user_email_addresses_on_email_address_id"
    t.index ["user_id", "email_address_id"], name: "index_user_email_addresses_on_user_id_and_email_address_id", unique: true
    t.index ["user_id", "use"], name: "index_user_email_addresses_on_user_id_and_use", unique: true
    t.index ["user_id"], name: "index_user_email_addresses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "activated_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_users_on_status"
    t.check_constraint "char_length(first_name) <= 50"
    t.check_constraint "char_length(first_name) >= 2"
    t.check_constraint "char_length(last_name) <= 50"
    t.check_constraint "char_length(last_name) >= 2"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "benefits", "jobs"
  add_foreign_key "employers", "companies"
  add_foreign_key "employers", "users"
  add_foreign_key "jobs", "employers"
  add_foreign_key "user_email_addresses", "email_addresses"
  add_foreign_key "user_email_addresses", "users"
end
