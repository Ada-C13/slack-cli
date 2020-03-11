#!/usr/bin/env ruby

require 'httparty'
require 'dotenv'

Dotenv.load

URL = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV['SLACK_API_TOKEN']
}

response = HTTParty.get(URL, query: query_parameters)

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