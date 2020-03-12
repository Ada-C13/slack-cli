#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'workspace.rb'

#CHANNEL_URL = "https://slack.com/api/conversations.list"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new()

  # TODO project
  # workspace = Workspace.new #creates a new workspace 

  puts "What would you like to do (please enter your selection number here):
  (1) Get a list of channels
  (2) Get a list of users
  (3) Quit"

  #user_input = gets.chomp.to_i

  puts workspace.list_users

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME