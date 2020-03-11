#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require_relative "workspace"
Dotenv.load

# def test
# url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
# response = HTTParty.get(url)
# p response
# end
#  p test

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
