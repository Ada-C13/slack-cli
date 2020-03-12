#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require_relative'workspace'

Dotenv.load



# unless EVN['SLACK_TOKEN']
#   puts "Could not load API key, please store in the environment variable 'SLACK_API_TOKEN'"
#   exit
# end

# URL = https://slack.com/api/channels.list

# query: {
#     query: search,
#     api_key: ENV['SLACK_TOKEN']
# }
# response = HTTParty.get 
def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

# As a user of the CLI program, I can list users and channels | ✔️?
# As a user of the CLI program, I can select users and channels | ✔️?
# As a user of the CLI program, I can show the details of a selected user or channel | ✔️?
# As a user of the CLI program, when I input something inappropriately, the program runs without crashing |