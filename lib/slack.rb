#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'httparty'


def ask_again
  puts "Choose from the following: 
  1. list users
  2. list channels
  3. select user
  4. select channel
  5. details
  6. send message

  -1. quit
  "
  return gets.chomp.to_i
end 


def main
  workspace = Workspace.new()
  puts "Welcome to the Ada Slack CLI!"
  input = ask_again
  recipient = nil 
  while input != -1

    if input == 1
      puts workspace.list_users.to_s
      input = ask_again
    elsif input == 2
      puts workspace.list_channels.to_s
      input = ask_again
    elsif input == 3
      puts "What is the user's ID?"
      recipient = workspace.select_user(gets.chomp)
      puts "User: #{recipient}"
      input = ask_again
    elsif input == 4
      puts "What is the channels's ID?"
      recipient = workspace.select_channel(gets.chomp)
      puts "Channel: #{recipient}"
      input = ask_again
    elsif input == 5
      puts workspace.get_details
      input = ask_again
    elsif input == 6
      puts "Input the message you would like to send:"
      workspace.send_message(gets.chomp)
      input = ask_again
    else
      puts "idk"
      input = ask_again
    end 
  end 
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME