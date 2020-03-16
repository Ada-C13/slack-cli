#!/usr/bin/env ruby
require 'dotenv'
require "table_print"
require_relative "workspace"

Dotenv.load 

# prompts user for their input and records it
def prompt_action 
  puts "You have six options: list users, list channels, select user, select channel, details or quit."
  puts "\n"
  print "Please enter your choice: "
  return gets.chomp.downcase
end

# controls command line interactivity 
def main
  workspace = Workspace.new

  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."
  puts "\n"

  user_input = prompt_action

  until user_input == "quit"

    case user_input 

    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
      puts "\n"

    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"

    else 
      puts "\n"
      puts "I cannot perform \"#{user_input}\". Please try again ->"
      puts "\n"
    end 

    user_input = prompt_action # call again until valid input is provided
  end 

  puts "\n"
  puts "Okay, thank you for using the Ada Slack CLI. Goodbye!"

end

main if __FILE__ == $PROGRAM_NAME