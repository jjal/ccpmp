class Commodity < ActiveRecord::Base
	has_many :prices
end
