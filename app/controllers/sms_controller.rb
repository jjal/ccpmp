require "rubygems"
require "mysql"
require 'yahoo-weather'

class SmsController < ApplicationController
  #interprets and delegates
  def index
    modkey = CGI.unescapeHTML(params[:body])[/^\s*([A-Za-z]+)\b/].downcase
    logger.info 'processing sms: '+params[:body]+' from number: '+(params[:number].nil? ? '' : params[:number])
    case modkey
    when 'xr'
      redirect_to :action => 'currency', :body => params[:body]
      return
    when 'pr'
      redirect_to :action => 'price', :body => params[:body]
      return
    when 'w'
      redirect_to :action => 'weather', :body => params[:body]
      return
    when 't'
      redirect_to :action => 'trader', :body => params[:body]
      return
    when 'c'
      redirect_to :action => 'collector', :body => params[:body]
      return
    when 'np'
      redirect_to :action => 'input', :body =>params[:body]
      return
    end
    #TODO: return some error code
    render :text => 'Error: unknown message type'
  end

  def price
    queryparms = params[:body].scan(/\w+/)

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

    #for now, just render the message view
    render :template=>'price/sms', :layout => 'blank'
  end

  def input
    queryparms = params[:body].scan(/\w+/)

    if(queryparms.length < 4)
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

    price = Price.new
    price.commodity_id = commodity.id
    price.market_id = mark.id
    price.amount = queryparms[3].to_f
    price.save
    render :text=> 'Saved '+price.commodity.code+ ' '+price.market.code+' '+price.amount.to_s+' at '+price.created_at.to_s
  end

  def weather
    render :text => 'Test weather forecast'
  end

  #look up traders
  def trader
    queryparms = params[:body].scan(/\w+/)

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

    agents = Agent.find(:all, :conditions => {:commodity_id => commodity.id, :market_id => mark.id})
    output = ''
    agents.each do |a|
      output << a.phone+ ' '
    end

    render :text=>output
  end

  def collector

  end

  #Perform currency exchange rate
  def currency
    
    queryparms = params[:body].scan(/\w+/)
    converted_money=CurrencyExchange.currency_exchange(queryparms[3].to_i, queryparms[1], queryparms[2])

    render :text => queryparms[3] +' '+ queryparms[1]+' = '+converted_money.to_s+' '+queryparms[2]

  end


end
