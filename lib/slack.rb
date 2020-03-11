#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'

Dotenv.load

TOKEN     = ENV["SLACK_API_TOKEN"]
SLACK_URL_CL = "https://slack.com/api/conversations.list"
SLACK_URL_UL = "https://slack.com/api/users.list"
SLACK_URL_CJ = "https://slack.com/api/conversations.join"
SLACK_URL_PM = "https://slack.com/api/chat.postMessage"

def test_slack
  # Get channels from slack
  query_parameters = { token: TOKEN }
  result = HTTParty.get(SLACK_URL_CL, query: query_parameters)
  
  puts result.code
  puts result["ok"]
  result["channels"].each do |channel|
    puts "ID = #{channel["id"]}, Name = #{channel["name"]}, creator = #{channel["creator"]}"
  end

  # Get users from slack
  query_parameters = { token: TOKEN }
  result = HTTParty.get(SLACK_URL_UL, query: query_parameters)
  
  puts result.code
  puts result["ok"]
  # ap result["members"].first
  result["members"].each do |member|
    puts "ID = #{member["id"]}, name = #{member["name"]}, real name = #{member["real_name"]}"
  end

  # Join general channel 
  query_parameters = { token: TOKEN, channel: "CV5S4LJPN" } # id for general channel
  result = HTTParty.post(SLACK_URL_CJ, query: query_parameters)
  
  puts result.code
  puts result["ok"]
   ap result

  # Send message to general channel
  query_parameters = { token: TOKEN, channel: "CV5S4LJPN", text: "testing 1,2,3" }
  result = HTTParty.post(SLACK_URL_PM, query: query_parameters)
  
  puts result.code
  puts result["ok"]
   ap result


  # Send message to Suely user
  query_parameters = { token: TOKEN, channel: "UV6AV2NRW", text: "testing 1,2,3" } # id for Suely user
  result = HTTParty.post(SLACK_URL_PM, query: query_parameters)
  
  puts result.code
  puts result["ok"]
   ap result
end


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
