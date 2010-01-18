require 'net/http'
require 'rubygems'
require 'hpricot'
require 'htmlentities'
require 'cgi'

class MessageController < ApplicationController

def index
	body = CGI.unescapeHTML(params[:body])
	servers = Array.new 6
	servers[0] = {:basehost => "wikipedia.org", :apipath => "/w/api.php", :name => "Wikipedia"}
	servers[1] = {:basehost => "wikiquote.org", :apipath => "/w/api.php", :name => "Wikiquote"}
	servers[2] = {:basehost => "wiktionary.org", :apipath => "/w/api.php", :name => "Wiktionary"}
	servers[3] = {:basehost => "wikisource.org", :apipath => "/w/api.php", :name => "Wikisource"}
	servers[4] = {:basehost => "wikibooks.org", :apipath => "/w/api.php", :name => "Wikibooks"}
	servers[5] = {:basehost => "wikinews.org", :apipath => "/w/api.php", :name => "Wikinews"}
	s=nil
	source = nil
	if(body =~ /^([A-Z])\b(.+)$/)
		source = $1
	case source
	when 'W'
		s = servers[0]
	when 'D'
		s = servers[2]
	else
		s = nil
	end
	end
	unless s == nil
		keyphrase = $2
		summary = ''
		
		res = Net::HTTP.get_response(URI.parse('http://en.'+s[:basehost]+s[:apipath]+'?action=parse&prop=text&format=xml&page='+CGI.escape(keyphrase.strip))).body
		res = HTMLEntities.new.decode(res)
		#this appears to fuck the command interpreter so use regex instead
		#hdoc = Hpricot(res) 
		#summary = (hdoc/"api/parse/text/p").first.inner_html.gsub(/<\/?[^>]*>/, "").gsub(/\([^\)]*\)/, "").gsub(/\[[^\]]*\]/, "").gsub(/ ,/,",")
		case source
		when 'W'
			if(res =~ /\<p\>(.*?)\<\/p\>/)
				summary = $1.gsub(/<\/?[^>]*>/, "").gsub(/\([^\)]*\)/, "").gsub(/\[[^\]]*\]/, "").gsub(/ ,/,",")
			else
				summary = ''
			end
		when 'D'
			defs = res.scan(/\<ol\>\w*\<li\>(.*?)\<\/li\>/)
			defs.each {|d| summary = summary + (summary==''?'':'; ') + d.gsub(/<\/?[^>]*>/, "").gsub(/\([^\)]*\)/, "").gsub(/\[[^\]]*\]/, "").gsub(/ ,/,",")}
		end
		
		if (summary.length < 5)
			render :text => "No information found."
		else
			#shorten
			summary = summary.slice(0,140)
			
			if(!summary.rindex(". ").nil?)
				summary = summary.slice(0, summary.rindex(". ") + 1)
			else				
				summary = summary.slice(0, summary.rindex(" ") + 1)
			end
			render :text => summary
		end
	end
end
end 
