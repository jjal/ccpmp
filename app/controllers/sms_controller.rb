class SmsController < ApplicationController
  #interprets and delegates
  def message
    modkey = CGI.unescapeHTML(params[:body])
    if(modkey =~ /^\w*([A-Za-z]+)\b(.+)$/)
      modkey = $1.downcase
    else
      modkey = nil
    end

    case modkey
    when 'xr'
      redirect_to :action => 'currency'
    when 'pr'
      redirect_to :action => 'price'
    when 'w'
      redirect_to :action => 'weather'
    when 't'
      redirect_to :action => 'trader'
    when 'c'
      redirect_to :action => 'collector'
    end
    #TODO: return some error code
  end

  def price
    queryparms = params[:body].split(/\w+/)

    if(queryparms.length > 3)
      #TODO: error, there should only be three parameters
    end

    commodity = Commodity.find(:first, :conditions => {:code => queryparms[1]})
    mark = Market.find(:first, :conditions => {:code => queryparms[2]})
    
    if(commodity.nil?)
      #TODO error
    end
    if(mark.nil?)
      #TODO error
    end

    price = Price.find(:first, :conditions => {:commodity_id => commodity.id, :market_id => mark.id})
    
    @markcode = mark.code
    @price = price.amount
    @commcode = commodity.code
    @pdate = price.created_at.strftime("%d/%m/%Y %H:%M")

    render :layout => 'blank'
  end

  def input
  end

  def weather
  end

  def trader
  end

  def collector

  end

  def currency
    #look up currency
  end


end
