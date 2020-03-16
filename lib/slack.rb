#!/usr/bin/env ruby
require 'table_print'
require "dotenv"
require "httparty"

require_relative 'workspace'

Dotenv.load

def main
  workspace = Workspace.new 
  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."

  user_input = prompt_for_input

  until user_input == "quit" || user_input == "exit"
    
    case user_input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name" 
      puts "\n"
      
    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
      
    when "select user"
      print "Please enter the user name or ID: "
      user_name = gets.chomp.to_s
      workspace.select_user(user_name)
      puts "\n"
      
    when "select channel"
      print "\n Please enter the channel name or ID: "
      channel_name = gets.chomp.to_s
      workspace.select_channel(channel_name)
      puts "\n"
      
    when "details"
      if workspace.selected == ""
        puts "\nYou haven't selected a user or channel!!! Try again!"
        puts "\n"
      else
        puts workspace.show_details
        user_input = nil
        puts "\n"
      end 

    when "send message"
      if workspace.selected == ""
        puts "\nYou haven't selected a user or channel!!! Try again!"
        puts "\n"
      else
        print "Please enter your message: "
        message = gets.chomp.to_s
        workspace.send_message(message)
        puts "\n"
      end
    else
      puts "Sorry, I didn't understand your request. Please try again."
      puts "\n"
    end

    user_input = prompt_for_input
  end 
  puts "Thank you for using the ADA Slack CLI!"
  puts "\n"
end

def prompt_for_input
  print "Please choose an option: \n - list users \n - list channels \n - select user \n - select channel \n - details \n - send message \n or quit \n"
  puts "--------------------------------------------"
  return gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME