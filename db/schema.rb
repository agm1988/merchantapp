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

ActiveRecord::Schema.define(version: 2019_12_05_124332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "merchants", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.string "email"
    t.integer "status", default: 0, null: false
    t.decimal "total_transaction_sum", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "merchant_id"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status", default: 0
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference_uuid"
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
  end

  add_foreign_key "transactions", "merchants"
end
