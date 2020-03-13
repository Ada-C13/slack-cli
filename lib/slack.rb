#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'

require_relative 'workspace.rb'

#CHANNEL_URL = "https://slack.com/api/conversations.list"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  # puts "#{workspace.channels.length} channels have been loaded."
  # puts "#{workspace.users.length} users have been loaded."

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
    tp workspace.list_channels
  elsif user_input == 2
    tp workspace.list_users
  elsif user_input == 3
    puts "Can do! Who would you like to send a message to?"
    send_to = gets.chomp
    workspace.select_user(send_to)
    puts "Great! #{workspace.selected.name} has now been selected."
  elsif user_input == 4
    puts "Can do! What channel would you like to send a message to?"
    send_to = gets.chomp
    workspace.select_channel(send_to)
    puts "Great! #{workspace.selected.name} has now been selected."
  elsif user_input == 5
    tp workspace.show_details
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME