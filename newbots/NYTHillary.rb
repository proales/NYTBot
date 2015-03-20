#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTHillary
# generated on 2015-03-19 11:46:38 -0400
#

consumer_key 'GNWuRtjdgyKmOsBuNEPvmzc5z'
consumer_secret 'JFV9aCSRiAQTiU1IQgePxsqgtB2KyxER9ahpbvhEYcYe6HUNll'

secret 'l8UKs0E4PTmvLLNIkHZDaQWsARdYXmjtuRxJd0ks0w8SM'
token '3097047119-lBF4FCw4HqtBpPUT2pwoZUv9uhCAwnVXmf4WzQb'

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
