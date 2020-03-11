#!/usr/bin/env ruby
require_relative 'workspace'

require 'httparty'
require 'dotenv'

# Tell dotenv to look for the .env file
Dotenv.load

USERS_URI = "https://slack.com/api/users.list"
CHANNELS_URI = "https://slack.com/api/conversations.list"

SLACK_TOKEN = ENV["SLACK_TOKEN"]



def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new


  # TODO project
  response = HTTParty.get(USERS_URI, query: {token: SLACK_TOKEN})
  puts response
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME