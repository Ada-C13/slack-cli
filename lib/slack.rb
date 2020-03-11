#!/usr/bin/env ruby

require "dotenv"
require "httparty"
require_relative "workspace"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end


# https://slack.com/api/channels.list?token=xoxb-994132166407-994615665957-EK5sTJjcfCP0o8jQGfelq7f4
 
def list_channels
  url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
  response = HTTParty.get(url)

  channels_list = []
  # looking for channels in response
  response["channels"].each do |channel|
    channels_list << channel["name"]
  end

  return channels_list
end

p test


main if __FILE__ == $PROGRAM_NAME
