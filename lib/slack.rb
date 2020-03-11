#!/usr/bin/env ruby
require_relative 'workspace'
require 'httparty'
require 'dotenv'

Dotenv.load

# SLACK_URL = "https://slack.com/api/conversations.list"
# TOKEN = ENV["SLACK_API_TOKEN"]

#list users username, real name, and Slack ID.
#list channels name, topic, member count, and Slack ID.




def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project


  
  p workspace.channels.slack_id

  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

# def list_channels(input)
#   list = []
#   input["channels"].each do |h|
#     a_hash = {}
#     a_hash["name"] = h["name"]
#     a_hash["topic"]= h["topic"]["value"]
#     a_hash["member_count"] = h["num_members"]
#     a_hash["slack_id"] =  h["id"]
#     list << a_hash
#   end 
#   return list 
# end 
