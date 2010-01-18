class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :markets
  end
end
