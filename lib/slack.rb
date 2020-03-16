#!/usr/bin/env ruby

require_relative "workspace"

require 'httparty'
require 'dotenv'

BASE_URL = "https://slack.com/api/conversations.list"
SLACK_API_TOKEN = ENV["SLACK_TOKEN"]

Dotenv.load 

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  response = HTTParty.get(BASE_URL, query: {token: SLACK_API_TOKEN })

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME