#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
Dotenv.load

# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = Workspace.new

#   # TODO project
  

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME


BASE_URL = "https://slack.com/api/channels.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

params = {token: SLACK_TOKEN}
response = HTTParty.get(BASE_URL, query: params)
p SLACK_TOKEN
p params
p response
