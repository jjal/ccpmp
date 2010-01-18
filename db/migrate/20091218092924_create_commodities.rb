class CreateCommodities < ActiveRecord::Migration
  def self.up
    create_table :commodities do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :commodities
  end
end
