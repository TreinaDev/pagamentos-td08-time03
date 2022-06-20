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

ActiveRecord::Schema[7.0].define(version: 2022_06_20_211120) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.string "full_name"
    t.integer "activation", default: 0
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "approvals", force: :cascade do |t|
    t.integer "admin_id"
    t.string "super_admin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_approvals_on_admin_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "registration_number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "registration_number"
    t.string "corporate_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credits", force: :cascade do |t|
    t.decimal "real_amount", precision: 10, scale: 2
    t.decimal "rubi_amount", precision: 10, scale: 2
    t.integer "exchange_rate_id", null: false
    t.integer "client_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 5
    t.index ["client_id"], name: "index_credits_on_client_id"
    t.index ["company_id"], name: "index_credits_on_company_id"
    t.index ["exchange_rate_id"], name: "index_credits_on_exchange_rate_id"
  end

  create_table "exchange_rate_approvals", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "exchange_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_exchange_rate_approvals_on_admin_id"
    t.index ["exchange_rate_id"], name: "index_exchange_rate_approvals_on_exchange_rate_id"
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.decimal "real", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_exchange_rates_on_admin_id"
  end

  add_foreign_key "approvals", "admins"
  add_foreign_key "credits", "clients"
  add_foreign_key "credits", "companies"
  add_foreign_key "credits", "exchange_rates"
  add_foreign_key "exchange_rate_approvals", "admins"
  add_foreign_key "exchange_rate_approvals", "exchange_rates"
  add_foreign_key "exchange_rates", "admins"
end
