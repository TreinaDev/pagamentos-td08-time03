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

ActiveRecord::Schema[7.0].define(version: 2022_06_29_223337) do
  create_table "admin_approvals", force: :cascade do |t|
    t.integer "admin_id"
    t.string "super_admin_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_approvals_on_admin_id"
  end

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

  create_table "bonus_conversions", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "bonus_percentage"
    t.integer "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_category_id", null: false
    t.integer "status", default: 10
    t.index ["client_category_id"], name: "index_bonus_conversions_on_client_category_id"
  end

  create_table "bonus_credits", force: :cascade do |t|
    t.integer "status", default: 0
    t.date "expiration_date"
    t.decimal "amount"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_bonus_credits_on_client_id"
  end

  create_table "client_categories", force: :cascade do |t|
    t.string "name"
    t.decimal "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 10
  end

  create_table "clients", force: :cascade do |t|
    t.string "registration_number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_category_id", null: false
    t.index ["client_category_id"], name: "index_clients_on_client_category_id"
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

  create_table "daily_credit_limits", force: :cascade do |t|
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "orders", force: :cascade do |t|
    t.string "order_code"
    t.integer "client_id", null: false
    t.decimal "transaction_total_value"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exchange_rate_id", null: false
    t.decimal "rate_used", precision: 10, scale: 2
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["exchange_rate_id"], name: "index_orders_on_exchange_rate_id"
  end

  add_foreign_key "admin_approvals", "admins"
  add_foreign_key "bonus_conversions", "client_categories"
  add_foreign_key "bonus_credits", "clients"
  add_foreign_key "clients", "client_categories"
  add_foreign_key "credits", "clients"
  add_foreign_key "credits", "companies"
  add_foreign_key "credits", "exchange_rates"
  add_foreign_key "exchange_rate_approvals", "admins"
  add_foreign_key "exchange_rate_approvals", "exchange_rates"
  add_foreign_key "exchange_rates", "admins"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "exchange_rates"
end
