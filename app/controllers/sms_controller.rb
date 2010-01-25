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
