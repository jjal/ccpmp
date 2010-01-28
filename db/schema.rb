# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100128121615) do

  create_table "agents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commodities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                    :null => false
    t.string   "code",       :limit => 5, :null => false
    t.integer  "camis_code",              :null => false
  end

  add_index "commodities", ["code"], :name => "code", :unique => true

  create_table "exchange_rates", :force => true do |t|
    t.string   "base_currency"
    t.string   "currency"
    t.float    "rate"
    t.date     "issued_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                    :null => false
    t.string   "code",       :limit => 5, :null => false
  end

  add_index "markets", ["code"], :name => "code", :unique => true

  create_table "prices", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",       :precision => 8, :scale => 2, :null => false
    t.integer  "market_id",                                  :null => false
    t.integer  "commodity_id",                               :null => false
  end

  create_table "provinces", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weather_forecasts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
