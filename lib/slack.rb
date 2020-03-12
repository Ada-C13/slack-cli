#!/usr/bin/env ruby

require 'httparty'
require 'dotenv'
require_relative "workspace"

Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"
KEY = ENV["SLACK_TOKEN"]

def main
  puts "Welcome to the Ada Slack CLI!"

  query_parameters = {token: KEY} 


  response = HTTParty.get(BASE_URL, query: query_parameters)
  
  puts "Thank you for using the Ada Slack CLI"
  puts response

  response["channels"].each do |chanel|
    puts chanel["name"]
  end

end


main if __FILE__ == $PROGRAM_NAME
