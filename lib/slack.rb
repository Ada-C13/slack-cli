#!/usr/bin/ruby
#
# Title  : Slack CLI - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : March 2020
# 

require 'table_print'
require_relative 'workspace'

# Method to prompt list of users
def list_users(workspace)
  puts "\nUser List\n\n"
  tp workspace.users, "id", "name", "real_name", "status_text", "status_emoji"
end

# Method to prompt list of channels
def list_channels(workspace)
  puts "\nChannel List\n\n"
  tp workspace.channels, "id", "name", "topic", "member_count"
end

# Method to select user
def select_user(workspace)
  print "Enter user id or name: "
  choice = gets.chomp
  begin
    workspace.select_user(choice)
  rescue => exception
    puts "Error: #{exception.message}"
  end
end

# Method to select channel
def select_channel(workspace)
  print "Enter channel id or name: "
  choice = gets.chomp
  begin
    workspace.select_channel(choice)
  rescue => exception
    puts "Error: #{exception.message}"
  end
end

# Method to show details
def show_details(workspace)
  begin
    puts workspace.show_details
  rescue => exception
    puts "Error: #{exception.message}"
  end
end

# Method to send message
def send_message(workspace)
  print "Enter a message: "
  msg = gets.chomp
  begin
    workspace.send_message(msg)
  rescue => exception
    puts "Error: #{exception.message}"
  end
end

# Show CLI options and call other methods
def main
  workspace = Workspace.new

  puts "Welcome to the Ada Slack CLI!"
  choice = ""
  while choice != "quit"
    puts "\nSlack Main Menu:"
    puts "1 - List Users (lu)"
    puts "2 - List Channels (lc)" 
    puts "3 - Select User (su)" 
    puts "4 - Select Channel (sc)"
    puts "5 - Show Details (sd)"
    puts "6 - Send Message (sm)"
    puts "7 - Quit (q)"
    print "\nWhat would you like to do? "
    choice = gets.chomp.downcase
    puts
    case choice
      when "list users", "lu", "1"
        list_users(workspace)
      when "list channels", "lc", "2"
        list_channels(workspace)
      when "select user", "su", "3"
        select_user(workspace)
      when "select channel", "sc", "4"
        select_channel(workspace)
      when "show details", "sd", "5"
        show_details(workspace)
      when "send message", "sm", "6"
        send_message(workspace)
      when "quit", "q", "7"
        choice = "quit"
      else
       puts "Invalid choice!"
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end # Main

main if __FILE__ == $PROGRAM_NAME