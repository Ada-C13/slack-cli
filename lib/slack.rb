#!/usr/bin/env ruby
require_relative 'workspace'
require 'httparty'
require 'dotenv'

Dotenv.load

SLACK_URL = "https://slack.com/api/conversations.list"
TOKEN = ENV["SLACK_API_TOKEN"]






def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  query_parameters = {token: TOKEN}
  result = HTTParty.get(SLACK_URL, query: query_parameters)
  
  # loop through channel names
  result["channels"].map {|h| puts h["name"]}
  


  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

