#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTModernLove
# generated on 2015-03-19 11:49:39 -0400
#

consumer_key 'BcB1GLg3dhKlsYn4i5bVQCnAH'
consumer_secret 'Ki5mHyywuV97kXQok6Eqya3W7lpikQ1frKtT0WqIRdX8H36caY'

secret 'Kk0hFzXjvdyusRoUskFMgrZ64uUEeS8TZj4OYmr33Gow3'
token '3097096792-bsY9KFCJnKYWKxEiuwhUdtuSLqTxvKDFsjsoy51'

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
