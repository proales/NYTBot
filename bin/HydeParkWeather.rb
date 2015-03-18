#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require 'rufus-scheduler'
require 'active_record'
require 'net/http'
require 'json'
require 'sqlite3'
require 'url_shortener'
require 'twitter'
require 'htmlascii'

scheduler = Rufus::Scheduler.new

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => '../test.db'
)

class Article < ActiveRecord::Base
end

class Account < ActiveRecord::Base
end

a = Account.last
puts "YYYY" + a.all

bitlyauth = UrlShortener::Authorize.new 'proales', 'R_b8f06dca741dbd98bc2855ea9c42fc7d'
bitlyclient = UrlShortener::Client.new(bitlyauth)

# set to fasle to send out tweets
debug_mode = true

# make sure at least one tweet happens in debug mode
if (debug_mode)
    user = Article.last
    user.destroy
end

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

def post_tweet(account, content)
    ymlConfig = YAML.load_file(account + '.yml')
    puts ymlConfig['consumer_key']
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ymlConfig['consumer_key']
        config.consumer_secret     = ymlConfig['consumer_secret']
        config.access_token        = ymlConfig['access_token']
        config.access_token_secret = ymlConfig['access_token_secret']
    end

    if debug_mode 
        client.update(content)
    else 
        puts "Debug mode: " + content
    end
end

scheduler.every '30s', :first_in => 0 do
    puts "New Run: "
    
    data = get_json()
    data["results"].each do |result|
        exists = Article.exists?(scoop_id: result["id"])
        if exists
            # article has been scanned skip
            puts "skipped " + result["id"]
        else
            # article is new tweet it out
            shorten = bitlyclient.shorten(result["url"])
            title = Htmlascii.convert(result["title"])
            tweet_content = title + " " + shorten.urls

            puts tweet_content
            #tweet tweet_content
            post_tweet("HydeParkWeather", tweet_content)

            p = Article.new
            p.account = "HydeParkWeather"
            p.scoop_id = result["id"]
            p.save
        end 
    end

end

scheduler.join












