#!/usr/bin/env ruby
require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'channel'
require_relative 'user'
require_relative 'recipient'

Dotenv.load


def main
  puts "-------------------------------------
  Welcome to the Ada Slack CLI!"
  @workspace = Slack::Workspace.new
  
  user_selection = ""

  until user_selection == "quit" || user_selection == "exit"
    user_selection = options 
    user_input(user_selection)
  end 

  closing 
end

def options 
  puts "-------------------------------------
  Would you like to:
  list users
  list channels
  select user
  select channel
  details
  send message
  quit"
  return gets.chomp
end

def user_input(user_selection)  
  if user_selection == "list users"
    tp @workspace.users
  elsif user_selection == "list channels"
    tp @workspace.channels
  elsif user_selection == "select user"
    puts "Enter the user name or ID"
    input = gets.chomp
    @workspace.select_user(input)
    selection = @workspace.selected
  elsif user_selection == "select channel"
    puts "Enter the channel name or ID"
    input = gets.chomp
    @workspace.select_channel(input)
    selection = @workspace.selected
  elsif user_selection == "details"
    tp @workspace.show_details(selection)
  elsif user_selection == "send message"
    @workspace.send_message
  elsif user_selection == "quit"
  else
    puts "*** Invalid selection, please try again. ***" 
  end 
end

def closing
  puts "Thank you for using the Ada Slack CLI"
  exit
end 

main if __FILE__ == $PROGRAM_NAME