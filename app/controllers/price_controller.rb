class PriceController < ApplicationController
active_scaffold :price
def sms
	comcode = params[:id]
	commodity = Commodity.find(:first, :conditions => {:code => comcode})
	
	price = Price.find(:first, :conditions => {:commodity_id => commodity.id})
	mark = Market.find(:first, :conditions => {:id => price.market_id})
	@markcode = mark.code
	@price = price.amount
	@commcode = commodity.code
	@pdate = price.created_at.strftime("%d/%m/%Y %H:%M")

render :layout => 'blank'
end
end
