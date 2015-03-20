#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTNewJersey
# generated on 2015-03-19 11:35:59 -0400
#

consumer_key 'jHIquNrTU623ObmfoYgun6Oml'
consumer_secret 'p3w39NYhJx5Wl5yYMb325A1Vr6ZtksB1eDULx01rYUm761xG38'

secret 'pdzdB4K6SpgWmmRbFSuUv3XjMo2WvNwZ7W2yIsQsMmrl1'
token '3097068592-1gucL68ge3mJVqM7HJDQsjWTOUQXWfE8iwxpC3h'

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
