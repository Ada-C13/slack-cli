#!/usr/bin/env ruby
require 'table_print'
require "dotenv"
require "httparty"
require "colorize"

require_relative './workspace'

Dotenv.load

def main
  workspace = Workspace.new 
  puts "\n"
  puts "Welcome to the Ada Slack CLI! \n This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels."

  user_input = prompt_for_input

  until user_input == "quit" || user_input == "exit"
    
    case user_input
    when "list users" 
      tp workspace.users, "slack_id", "name", "real_name", "status_emoji"
      puts "\n"
      
    when "list channels"
      tp workspace.channels, "name", "topic", "memeber_count", "slack_id"
      puts "\n"
      
    when "select user"
      print "Please enter the user name or ID: ".bold
      user_name = gets.chomp.to_s
      workspace.select_user(user_name)
      puts "\n"
      
    when "select channel"
      print "\n Please enter the channel name or ID: ".bold
      channel_name = gets.chomp.to_s
      workspace.select_channel(channel_name)
      puts "\n"
      
    when "details"
      if workspace.selected == ""
        puts "\nYou haven't selected a user or channel!!! Try again!".bold
        puts "\n"
      else
        workspace.show_details
        user_input = nil
        puts "\n"
      end 

    when "send message"
      if workspace.selected == ""
        puts "\nYou haven't selected a user or channel!!! Try again!".bold
        puts "\n"
      else
        print "Please enter your message: "
        message = gets.chomp.to_s
        workspace.send_message(message)
        puts "\n"
      end

    #Optional - can change global settings for the program include the username for the bot and an emoji to use as an icon

    when "update user profile setting"
      if workspace.selected.class != User
        puts "\nYou would need to select your own user id first, maybe try again?".bold
        puts "\n"
      else
        print "\n enter the name that you would like to change your profile name to:".bold
        new_name = gets.chomp.to_s

        print "\n enter the emoji you would like to use"
        new_emoji = gets.chomp.to_s
        workspace.set_profile_setting(new_name, new_emoji)
        if workspace.set_profile_setting(new_name, new_emoji)
          puts "\n Your profile has been successfully updated!".blue
        else
          puts "\n It didn't go thru, you might not be authorized to change their profile. Sorry :(".cyan.on_blue.bold
        end
      end

    else
      puts "Sorry, I didn't understand your request. Please try again.".yellow.bold
      puts "\n"
    end

    user_input = prompt_for_input
  end 


  puts "Thank you for using the ADA Slack CLI!"
  puts "\n"
end

def prompt_for_input
  print "Please choose an option: \n - list users \n - list channels \n - select user \n - select channel \n - details \n - send message \n - update user profile setting  \nor quit \n"
  puts "--------------------------------------------"
  return gets.chomp.downcase
end


main if __FILE__ == $PROGRAM_NAME



#As a user, I can see a history of messages sent to the currently selected recipient.
# If I change recipients, the message list should also change