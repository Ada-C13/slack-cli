#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require_relative 'workspace'

Dotenv.load
BASE_URL = "https://slack.com/api/conversations.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  response = HTTParty.get(BASE_URL, query: {token: SLACK_TOKEN})

  # response["channels"].each do |channel|
  #   puts channel["name"]
  # end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME