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
  (3) select user
  (4) select channel
  (5) details
  (6) quit
  \n Selection: "


  selection = gets.chomp

  puts ""

  return selection
end

def main
  # interface layout inspired by instructor solar system implementation
  program_running = true

  while program_running
    workspace = Workspace.new
    user_choice = get_user_choice

    case user_choice.downcase
    when "list users", "1"
      tp workspace.users, "name", "real_name", "slack_id"
      
    when "list channels", "2"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"

    when "select user", "3"
      # TODO

    when "select channel", "4"
      # TODO

    when "details", "5"
      # TODO

    when "quit", "6"
      program_running = false
      puts "Thank you for using the Ada Slack CLI!"

    else
      puts "Invalid selection. Please provide a valid action."
    end
  end
end



main if __FILE__ == $PROGRAM_NAME