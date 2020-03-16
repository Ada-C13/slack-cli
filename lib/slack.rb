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
  (6) send message
  (7) quit
  \n Selection: "


  selection = gets.chomp

  puts ""

  return selection
end

def main
  # interface layout inspired by instructor solar system implementation
  program_running = true
  workspace = Workspace.new
    

  while program_running
    user_choice = get_user_choice

    case user_choice.downcase
    when "list users", "1"
      tp workspace.users, "name", "real_name", "slack_id"
      
    when "list channels", "2"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"

    when "select user", "3"
      print "Please provide a user name: "
      puts workspace.select_user

    when "select channel", "4"
      print "Please provide a channel name: "
      puts workspace.select_channel

    when "details", "5"
      if workspace.selected == nil
        puts "No channel or user selected."
      else
        workspace.show_details
      end

    when "send message", "6"
      if workspace.selected == nil
        puts "No channel or user selected."
      else
        print "Enter your message: "
        workspace.send_message
      end

    when "quit", "7"
      program_running = false
      puts "Thank you for using the Ada Slack CLI!"

    else
      puts "Invalid selection. Please provide a valid action."
    end
  end
end



main if __FILE__ == $PROGRAM_NAME