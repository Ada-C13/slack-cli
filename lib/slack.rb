#!/usr/bin/env ruby
require_relative 'workspace'
# require 'httparty'
# require 'dotenv'

# # Tell dotenv to look for the .env file
# Dotenv.load

def display_options
  puts "\nEnter one of the following options."
  puts "1. list users"
  puts "2. list channels"
  puts "0. quit"
end



def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  control_loop = true

  while control_loop
    display_options
    choice = gets.chomp
    case choice
      when "1", "list users"
        workspace.list_users
      when "2", "list channels"
        workspace.list_channels
      when "0", "quit", "exit"
        control_loop = false
    end
  end

  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME


# USERS_URI = "https://slack.com/api/users.list"
# CHANNELS_URI = "https://slack.com/api/conversations.list"

# SLACK_TOKEN = ENV["SLACK_TOKEN"]

# response = HTTParty.get(USERS_URI, query: {token: SLACK_TOKEN})
# puts response