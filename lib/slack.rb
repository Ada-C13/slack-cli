# !/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'

Dotenv.load

def get_user_choice
  puts "\n"
  puts "Welcome to the Ada Slack CLI!"
  print "Please select one of the options: 
  (1) list users
  (2) list channels
  (3) quit
  \n Selection: "


  selection = gets.chomp

  puts ""

  return selection
end

def main
  # interface layout inspired by instructor solar system implementation
  program_running = true

  while program_running

    user_choice = get_user_choice

    case user_choice.downcase
    when "list users", "1"
      workspace = Workspace.new
      tp workspace.users, "name", "real_name", "slack_id"
      
    
    when "list channels", "2"
      workspace = Workspace.new
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
    
    when "quit", "3"
      program_running = false
      puts "Thank you for using the Ada Slack CLI!"
      
    else
      puts "Invalid selection. Please provide a valid action."
    end
  end
end



main if __FILE__ == $PROGRAM_NAME