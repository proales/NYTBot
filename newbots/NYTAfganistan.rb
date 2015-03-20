#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot NYTAfganistan
# generated on 2015-03-19 11:54:34 -0400
#

consumer_key '8zQXPgB4Bms9IzCFUtNgWbKgB'
consumer_secret 'zmcGsgkxW23oy0BxqPAlqlBWyYU7XUM9ERNLui1bfzrvmTQUbL'

secret 'XTQK8ixKt6eoVACQvj8EhTR8TDQUgrXy3roq0XzfuHKPZ'
token '705365683-lYjepOUJIRBII9WGTBPvfKX1SpuuzL3Sn5PjkX3u'

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
