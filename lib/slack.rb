#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'

#list users username, real name, and Slack ID.
#list channels name, topic, member count, and Slack ID.

def list_options
  puts "Please enter one of the followings:"
  puts "===================================="
  puts "list users"
  puts "list channels"
  puts "select channel"
  puts "select user"
  puts "details"
  puts "send message"
  puts "fun message"
  puts "quit"
  puts "===================================="
end 

def take_input
  gets.chomp
end 

def pretty_up
  puts "########################################"
end 

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCli::Workspace.new
  input = "not quit"

  while input != "quit"
    list_options
    input = take_input 

    if input == "list channels"
      puts "Cool, here are the channels..."
      tp workspace.channels , :name,:topic, :member_count, :slack_id

    elsif  input == "list users"
      puts "Sweet, here are the users"
      tp workspace.users , :name,:real_name, :slack_id, :status_text, :status_emoji

    elsif input == "select channel"
      puts "What channel name?"
      name = take_input.to_s
      workspace.select_channel(name)
      puts "#{workspace.selected.name} is selected!"


    elsif input == "select user"
      puts "Which user name?"
      name = take_input.to_s

      workspace.select_user(name)
      puts "#{workspace.selected.name} is selected!"

    elsif input == "details"

      if workspace.selected == nil 
        puts "No channel or user was selected!"
      else 
        puts workspace.show_details
      end 

    elsif input == "send message"
      
      if workspace.selected == nil
        puts "No channel or user was selected!"
      else 
        puts "Please type in the message:"
        message = take_input.to_s
        pretty_up
        puts "OKAY. Sending the following message:#{message}..."
        pretty_up
        workspace.selected.send_msg(message)
        puts "message sent!"
      end 

    elsif input == "fun message"

      if workspace.selected == nil
        puts "No channel or user was selected!"
      else 
        puts "Please type in the message:"
        msg = take_input.to_s
        puts "emoji (:bug)"
        emoji = take_input.to_s
        puts "name to show:"
        name_to_show = take_input.to_s
        workspace.selected.msg_emoji_name(msg,emoji,name_to_show)
        puts "fun message sent!"
      end 


    elsif input == "quit"
      next 
    else
      puts "not a valid input"
    end 
   
  end 
  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

