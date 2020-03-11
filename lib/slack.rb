#!/user/bin/env ruby
require "httparty"
require "awesome_print"
require "dotenv"
require_relative 'workspace'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

def get_channels
  response = HTTParty.get(BASE_URL, query: {token: SLACK_TOKEN})
  channels = []
  response['channels'].each do |channel|
    channels << channel['name'] #outputs channels names
  end

  return channels
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  
  get_channels

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME