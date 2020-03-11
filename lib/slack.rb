#!/usr/bin/env ruby
require_relative 'workspace'

require 'dotenv'
require 'httparty'
require "awesome_print"

# Dotenv.load 

# # Tell dotenv to look for the .env file !!!
# unless ENV["SLACK_TOKEN"]
#   puts "Could not load locaiton IQ key. Add `SLACK_TOKEN` in the environment variable"
#   exit 
# end 

# # https://slack.com/api/channels.list?token=xoxb-992039065285-979548775234-AhHSVMyT2ZeaYvZusTuP8QNO
# URL = "https://slack.com/api/channels.list"


# response = HTTParty.get(URL, query: {
#   token: ENV["SLACK_TOKEN"]
# })

# response_date = JSON.parse(response.body)

# # p response_date.class # hash 

# channels = response_date["channels"]

# channels.each do |channel|
#   p channel["name"]
# end 

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new

  # TODO project


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME