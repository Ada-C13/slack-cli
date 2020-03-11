#!/usr/bin/env ruby
require 'HTTParty'
require 'dotenv'

Dotenv.load

query = {
  token: ENV["SLACK_API_TOKEN"]
}

url = "https://slack.com/api/channels.list"
response = HTTParty.get(url, query: query)

response["channels"].each do |channel|
  puts channel["name"]
end 

# def main
#   puts "Welcome to the Ada Slack CLI!"
#   workspace = Workspace.new

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME