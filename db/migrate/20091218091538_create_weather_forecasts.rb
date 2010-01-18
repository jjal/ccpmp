class CreateWeatherForecasts < ActiveRecord::Migration
  def self.up
    create_table :weather_forecasts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :weather_forecasts
  end
end
