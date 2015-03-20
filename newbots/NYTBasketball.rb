#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTBasketball
# generated on 2015-03-19 11:43:03 -0400
#

consumer_key 'fWlZR3bnmaaDNr6Tip5LzHf4F'
consumer_secret '9o9CKeys0owUoSe0XXP67ANNnWHJvUOcxDq6ho2VML5vXyzD10'

secret '2RJY2MTZxLZ5pZp6XBVs1sxwdmOklT6mgSVPnZxrkeoTI'
token '3097084666-Gd9hkZYQFbyQ12XHOB99eHDBsQplOzF5vGSv5WA'

# remove this to send out tweets
debug_mode

# remove this to update the db
no_update
# remove this to get less output when running
verbose

# here's a list of users to ignore
blacklist "abc", "def"

# here's a list of things to exclude from searches
exclude "hi", "spammer", "junk"

search "keyword" do |tweet|
 reply "Hey #USER# nice to meet you!", tweet
end

replies do |tweet|
  reply "Yes #USER#, you are very kind to say that!", tweet
end
