#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'workspace.rb'

#CHANNEL_URL = "https://slack.com/api/conversations.list"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  p workspace.Recipient
  # puts "#{workspace} channels have been loaded."
  #puts "#{workspace.users.length} users have been loaded."
  # TODO project
  # workspace = Workspace.new #creates a new workspace 

  puts "What would you like to do (please enter your selection number here):
  (1) Get a list of channels
  (2) Get a list of users
  (3) Select user
  (4) Select channel
  (5) Details
  (6) Send message
  (3) Quit"

  user_input = gets.chomp.to_i

  if user_input == 1
    tp workspace.channels#.load_all
  elsif user_input == 2
    tp workspace.users#.load_all
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME