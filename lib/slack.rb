#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'workspace'
Dotenv.load

def recipient_available?(current_recipient)
  if current_recipient.nil?
    puts "No current recipient selected."
  else
    puts "What message would you like to send?"
    current_recipient.send_message(gets.chomp)
  end
end

def selected_recipient?(current_recipient)
  if current_recipient.nil?
    puts "Recipient does not exist"
  else
    puts "You have selected the current recipient: #{current_recipient.name}"
    return current_recipient
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "What would you like to do?"
  puts "Your options are: list_members, list_channels, select_user, select_channel, details, or quit"

  user_action = gets.chomp.downcase

  until user_action == 'quit'
    case user_action
    when 'list_members'
      tp workspace.users
    when 'list_channels'
      tp workspace.channels
    when 'select_user','select_channel'
      puts "Please provide either a recipient name or Slack ID:"
      current_recipient = workspace.select_recipient(gets.chomp)
      selected_recipient?(current_recipient)
    when 'details'
      tp current_recipient
    when 'send_message'
      puts recipient_available?(current_recipient)
    else
      puts "Looks like this isn't a valid option."
    end

    puts "What would you like to do next?"
    puts "Your options are: list_members, list_channels, select_user, select_channel, details, send_message or quit"
    user_action = gets.chomp.downcase
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

# what happens if username and channel name are the same?