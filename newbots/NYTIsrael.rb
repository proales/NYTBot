#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTIsrael
# generated on 2015-03-19 11:26:33 -0400
#

consumer_key 'oLAWRBCUXARALe4RmpgTJAaYx'
consumer_secret 'DMUaLAACq96Goxc2r5lquxmdJtUjkWk1dfHOVfW860jlLK9mpV'

secret 'qb9GWl7B19RMDdroJHNwEDhta3B95mNEojKCEKm6DgYlW'
token '3096968709-FX6tTuXtgTHWXHpFdakzoPJp738GsJX0b8eXZPs'

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
