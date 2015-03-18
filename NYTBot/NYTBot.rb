#!/usr/bin/env ruby

require 'rubygems'
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
  :database => 'NYTBot.db'
)

class Article < ActiveRecord::Base
end

class Account < ActiveRecord::Base
end

# set to fasle to send out tweets
$debug_mode = false
$destroy_last = false

# make sure at least one tweet happens in debug mode
if ($debug_mode || $destroy_last)
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

def post_tweet(account, content, image)
    ymlConfig = YAML.load_file(account + '.yml')
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ymlConfig['consumer_key']
        config.consumer_secret     = ymlConfig['consumer_secret']
        config.access_token        = ymlConfig['access_token']
        config.access_token_secret = ymlConfig['access_token_secret']
    end

    if $debug_mode 
        puts "Debug mode: " + content + image.present?
    else
        if image.present? 
            client.update_with_media(content, File.new(image))
        else     
            client.update(content)
        end
    end
end

def get_short_url(long_url) 
    bitlyauth = UrlShortener::Authorize.new 'proales', 'R_b8f06dca741dbd98bc2855ea9c42fc7d'
    bitlyclient = UrlShortener::Client.new(bitlyauth)
    shorten = bitlyclient.shorten(long_url).urls
    shorten
end    

def get_image(multimedia)
    data = nil

    if multimedia.present?
        thumb = multimedia.find{|image| image["format"] == "Normal" }
        if !thumb.present?
            thumb = multimedia.find{|image| image["format"] == "Large" }
        end
        if !thumb.present?
            thumb = multimedia.find{|image| image["format"] == "square320" }
        end
        if !thumb.present?
            thumb = multimedia.find{|image| image["format"] == "Standard Thumbnail" }
        end
        if thumb.present?
            url = thumb["url"]
            uri = URI(url)
            Net::HTTP.start(uri.host, uri.port) do |http|
                response = http.get(uri.request_uri)
                open("temp.jpg" ,"wb") { |file|
                    file.write(response.body)
                }
                data = "temp.jpg"
            end
        end    
    end    

    data
end    

def update_run()
    puts "New Run: "
    
    data = get_json()
    data["results"].each do |result|
        exists = Article.exists?(scoop_id: result["id"])
        if exists
            # article has been scanned skip
            puts "skipped " + result["id"] + " " + result["title"][0..10]
        else
            # article is new tweet it out
            shortened_url = get_short_url(result["url"])
            title = Htmlascii.convert(result["title"])
            tweet_content = title + " " + shortened_url
            tweet_image = get_image(result["multimedia"])
            
            puts tweet_content

            matchingAll = Account.where(all: "1")
            matchingAll.each do |account|
                puts "all tweets match for " + account.name
                post_tweet(account.name, tweet_content, tweet_image)
            end    

            matchingSections = Account.where(section: result["section"])
            matchingSections.each do |account|
                puts "section match for " + account.name
                post_tweet(account.name, tweet_content, tweet_image)
            end    

            if result["des_facet"].present?
                result["des_facet"].each do |topic|
                    matchingTopic = Account.where(topic: topic)
                    matchingTopic.each do |account|
                        puts "topic match for " + account.name
                        post_tweet(account.name, tweet_content, tweet_image)
                    end    
                end    
            end
                
            p = Article.new
            p.scoop_id = result["id"]
            p.save
        end 
    end
end 

# run once when program is started
update_run()

# then every 30 seconds after that
scheduler.every '30s', :first_in => 0 do
   update_run()
end

scheduler.join












