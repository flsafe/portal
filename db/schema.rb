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

ActiveRecord::Schema.define(version: 20150521023727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_messages", force: :cascade do |t|
    t.string   "type"
    t.integer  "school_id"
    t.integer  "application_id"
    t.integer  "student_id"
    t.integer  "employer_id"
    t.integer  "staff_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_event_id"
    t.integer  "staffer_id"
  end

  create_table "application_events", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.date     "event_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "application_id"
    t.text     "description"
    t.integer  "staffer_id"
  end

  add_index "application_events", ["application_id"], name: "index_application_events_on_application_id", using: :btree
  add_index "application_events", ["staffer_id"], name: "index_application_events_on_staffer_id", using: :btree

  create_table "application_recommendations", force: :cascade do |t|
    t.text     "recommendation_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "staffer_id"
    t.integer  "application_id"
  end

  add_index "application_recommendations", ["application_id"], name: "index_application_recommendations_on_application_id", using: :btree
  add_index "application_recommendations", ["staffer_id", "application_id"], name: "app_recs_uniq_staffer_id_application_id", unique: true, using: :btree
  add_index "application_recommendations", ["staffer_id"], name: "index_application_recommendations_on_staffer_id", using: :btree

  create_table "applications", force: :cascade do |t|
    t.text     "cover_letter"
    t.boolean  "reviewed"
    t.integer  "opportunity_id"
    t.integer  "student_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.text     "resume"
    t.string   "resume_file"
    t.string   "application_state",              default: "pending"
    t.integer  "application_state_changed_by"
    t.datetime "application_state_changed_date"
  end

  add_index "applications", ["application_state"], name: "index_applications_on_application_state", using: :btree
  add_index "applications", ["opportunity_id"], name: "index_applications_on_opportunity_id", using: :btree
  add_index "applications", ["student_id", "opportunity_id"], name: "index_applications_on_student_id_and_opportunity_id", unique: true, using: :btree
  add_index "applications", ["student_id"], name: "index_applications_on_student_id", using: :btree

  create_table "campuses", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "custom_domain"
    t.string   "website"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "school_id"
  end

  add_index "campuses", ["school_id"], name: "index_campuses_on_school_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "invites", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "invite_type"
    t.string   "email"
    t.string   "semester"
    t.integer  "year"
    t.integer  "campus_id"
    t.integer  "company_id"
    t.integer  "school_id"
  end

  add_index "invites", ["email"], name: "index_invites_on_email", unique: true, using: :btree
  add_index "invites", ["token"], name: "index_invites_on_token", unique: true, using: :btree

  create_table "opportunities", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.boolean  "is_open"
    t.boolean  "is_affilated"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "company_id"
    t.text     "skills"
    t.text     "requirements"
    t.integer  "employer_id"
    t.integer  "applications_count"
  end

  add_index "opportunities", ["company_id"], name: "index_opportunities_on_company_id", using: :btree

  create_table "opportunity_recommendations", force: :cascade do |t|
    t.integer  "staffer_id"
    t.integer  "student_id"
    t.integer  "opportunity_id"
    t.text     "recommendation_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_recommendations", ["opportunity_id"], name: "index_opportunity_recommendations_on_opportunity_id", using: :btree
  add_index "opportunity_recommendations", ["staffer_id", "student_id", "opportunity_id"], name: "unique_staffer_student_opportunity", unique: true, using: :btree
  add_index "opportunity_recommendations", ["staffer_id"], name: "index_opportunity_recommendations_on_staffer_id", using: :btree
  add_index "opportunity_recommendations", ["student_id"], name: "index_opportunity_recommendations_on_student_id", using: :btree

  create_table "partnerships", force: :cascade do |t|
    t.integer  "employer_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "custom_domain"
    t.string   "website"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "campus_id"
  end

  add_index "schools", ["campus_id"], name: "index_schools_on_campus_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "password_digest"
    t.integer  "role",            default: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "school_id"
    t.integer  "company_id"
    t.string   "type"
    t.string   "avatar"
    t.string   "phone"
    t.string   "github_token"
    t.integer  "semester"
    t.integer  "year"
    t.integer  "campus_id"
    t.integer  "grad_year"
  end

  add_index "users", ["campus_id"], name: "index_users_on_campus_id", using: :btree
  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  add_foreign_key "applications", "opportunities"
  add_foreign_key "applications", "users", column: "student_id"
  add_foreign_key "campuses", "schools"
  add_foreign_key "schools", "campuses"
  add_foreign_key "users", "campuses"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "schools"
end
