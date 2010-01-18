class Price < ActiveRecord::Base
	belongs_to :market
	belongs_to :commodity
end
