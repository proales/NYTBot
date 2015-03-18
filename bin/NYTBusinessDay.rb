#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTBusinessDay
# generated on 2015-03-18 14:46:17 -0400
#

consumer_key 'qGGzGbVbXikuxMzR0Y3H8oK6s'
consumer_secret 'DzaKgrWlMQT9H6BzBrP1YAO8wx4JuDm5uEWktvudHjc98TCw8q'

secret '6F44osMXbM02kGvsgtMD1wiu0rJhWAlRXsp7g4NRvvbgE'
token '3095120951-ny8HsZ1RdwVWZxH6ZuaJ1NPZ4Bico62ZHBHeQPy'

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
