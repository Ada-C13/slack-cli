#!/usr/bin/env ruby
require 'dotenv'
require "table_print"
require_relative "workspace"

Dotenv.load 

# prompts user for their input and records it
def prompt_action 
  puts "Choose an option: list users, list channels, or quit."
  return gets.chomp.downcase
end

# controls command line interactivity 
def main
  workspace = Workspace.new

  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."
  
  user_input = prompt_action

  until user_input == "quit"

    case user_input 

    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"

    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"

    else 
      puts "I cannot perform \"#{user_input}\". Please try again.\n"
    end 

    user_input = prompt_action # call again until valid input is provided
  end 

  puts "Thank you for using the Ada Slack CLI. Goodbye!"

end

main if __FILE__ == $PROGRAM_NAME