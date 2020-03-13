#!/usr/bin/env ruby
require 'HTTParty'
require 'dotenv'
require_relative 'workspace'
require_relative 'channel'
require_relative 'user'
require_relative 'recipient'

Dotenv.load



def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  query = {
    token: ENV["SLACK_API_TOKEN"]
  }
  
  url = "https://slack.com/api/channels.list"
  response = HTTParty.get(url, query: query)
  
  response["channels"].each do |channel|
    puts channel["name"]
  end 

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME