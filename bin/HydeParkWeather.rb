#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require 'rufus-scheduler'
require 'active_record'
require 'net/http'
require 'json'
require 'sqlite3'
require 'url_shortener'

scheduler = Rufus::Scheduler.new

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => '../test.db'
)

class Article < ActiveRecord::Base
end

bitlyauth = UrlShortener::Authorize.new 'proales', 'R_b8f06dca741dbd98bc2855ea9c42fc7d'
bitlyclient = UrlShortener::Client.new(bitlyauth)

# remove this to send out tweets
# debug_mode

# return the first user
user = Article.first
user.destroy

def get_json()   
 uri = URI("http://internal.du.nytimes.com/svc/news/v3/all/recent.json")
 data = nil
	Net::HTTP.start(uri.host, uri.port) do |http|
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)
		data = JSON.parse(response.body)
	end
 data
end

scheduler.every '60s', :first_in => 0 do
    data = get_json()
    data["results"].each do |result|
    	exists = Article.exists?(scoop_id: result["id"])
    	if exists
    		# article has been scanned skip
    		puts "skipped " + result["id"]
    	else
    		# article is new tweet it out
    	    shorten = bitlyclient.shorten(result["url"])
			tweet_content = result["title"] + " " + shorten.urls

    		puts tweet_content
    		tweet tweet_content

    		p = Article.new
			p.account = "HydeParkWeather"
			p.scoop_id = result["id"]
			p.save
    	end	
    end

    puts "XXX"
end

scheduler.join












