#!/usr/bin/env ruby
require "httparty"
require "dotenv"

require_relative "workspace"

# Tell dotenv to look for the .env file
Dotenv.load # from root folder?

# BASE_URL = ""
KEY = ENV["SLACK_TOKEN"]

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

#### WAVE 0 TEST: Use HTTParty to send a GET request to the channels.list endpoint:
BASE_URL = "https://slack.com/api/"
GET_URL = "#{BASE_URL}conversations.list" # Returns a list of limited channel objects

def get_request
  response = HTTParty.get(
    GET_URL, {
      headers: { "Content-Type" => "application/x-www-form-urlencoded",
        "charset" => "utf-8" },
      query: {
        token: KEY,
        exclude_members: true #Exclude the members collection from each channel
      },
    }
  )
  

  return response.body
  # return response.code == 200 && response.parsed_response["ok"]
end
puts get_request

### END OF WAVE 0 TEST

# Ruby uses __FILE__ to hold the current source file name. A prepended $ on a variable's name indicates a global variable.
main if __FILE__ == $PROGRAM_NAME

# Verification:
# Use the dotenv gem to load environment variables
# Use HTTParty to send a GET request to the channels.list endpoint
# Check that the request completed successfully, and print relevant information to the console if it didn't
# Loop through the results and print out the name of each channel
# If your tokens are set up correctly, each of you should be able to run this script.

# Objective
# We will write a complete command-line application that interacts with Slack. This application will be able to:

# List users and channels
# See details about a user or channel
# Send a message to a user or channel

# Set up a new Slack Workspace, channels, and users just for this project
# Write Ruby code to interact with the users and channels from that workspace

# All User-related information that slack.rb receives should be returned from calling a method defined in the Workspace class.
