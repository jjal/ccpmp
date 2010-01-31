class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.double :amount
      t.int :market_id
      t.int :province_id
      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
