#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"
# SLACK_TOKEN="xoxb-991668681700-992319339045-1rqVRB8RaNIcsSZpkAE2YpI7"
KEY = ENV["SLACK_TOKEN"]

def main
  puts "Welcome to the Ada Slack CLI!"
  # workspace = Workspace.new

  # TODO project
  query_parameters = {token: KEY} 
  
  response = HTTParty.get(BASE_URL, query: query_parameters)

  puts "Thank you for using the Ada Slack CLI"
  puts response

end

puts main

main if __FILE__ == $PROGRAM_NAME