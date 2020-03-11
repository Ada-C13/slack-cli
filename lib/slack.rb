# !/usr/bin/env ruby

require 'dotenv'
require 'httparty'

require_relative 'workspace.rb'

Dotenv.load

SLACK_TOKEN = ENV['SLACK_TOKEN']

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  
  # TODO project
  
  puts "Thank you for using the Ada Slack CLI"
end

def token_test
  url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
  response = HTTParty.get(url)
  
  channel_list = []
  # looking at "channels" in response
  # for each thing in channels (channel), look at the thing labelled "name", shove that into the array
  response['channels'].each do |channel|
    channel_list << channel["name"]
  end
  
  return channel_list
end

puts token_test

# main if __FILE__ == $PROGRAM_NAME