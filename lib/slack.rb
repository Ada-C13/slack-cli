#!/usr/bin/env ruby
require "dotenv"
require "table_print"

require_relative 'workspace'

Dotenv.load

def main
  workspace = Workspace.new
  puts "Welcome to the Ada Slack CLI!"

  user_option = ""

  until user_option == "quit"
    puts "\nCHOOSE AN OPTION
    - list users
    - list channels
    - select user
    - select channel
    - details
    - send message
    - quit"
    print "=> "
    user_option = gets.chomp

    case user_option
    when "list users"
      tp workspace.users, "name", "real_name", "slack_id"

    when "list channels"
      tp workspace.channels, "name", "topic", "slack_id", "member_count"

    when "select user"
      puts "\nInput user ID or Name"
      print "=> "
      user = workspace.select_user(gets.chomp)

    when "select channel"
      puts "\nInput channel ID or Name"
      print "=> "
      channel = workspace.select_channel(gets.chomp)

    when "details"
      if workspace.selected.nil?
        puts "\nSorry, you have nothing selected"
      else
        puts "\nHere are details for #{workspace.selected.name}"
        workspace.show_details
      end

    when "send message"
      if workspace.selected.nil?
        puts "\nSorry, you have not selected a Channel or User to send a message to"
      else
        puts "Please enter a message you would like to send to #{workspace.selected.name}"
        print "=> "
        workspace.new_message(gets.chomp)
        puts "The message was sent!"
      end
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME