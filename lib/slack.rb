#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'workspace'
Dotenv.load

MESSAGE_URL = 'https://slack.com/api/chat.postMessage'

def select_recipient (object_type)
  puts "Please provide either a recipient name or Slack ID:"
  user_input = gets.chomp
  find_object(user_input, object_type)
end

def find_object(search_term, object_type)
  object_type.find {|object| 
    object.id == search_term || object.name == search_term}
end

def send_message(selected_recipient)
  puts "What message would you like to send?"
  message = gets.chomp

  query_parameters = {
    token: ENV['SLACK_TOKEN'],
    channel: selected_recipient.id,
    text: message
  }
  
  response = HTTParty.post(MESSAGE_URL,query: query_parameters)
end

def select_confirmation(current_recipient)
  if current_recipient.nil?
    puts "Recipient does not exist"
  else
    puts "You have selected the current recipient: #{current_recipient.name}"
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
      puts "List of Members:"
      tp workspace.users
    when 'list_channels'
      puts "List of Channels:"
      tp workspace.channels
    when 'select_user'
      current_recipient = select_recipient(workspace.users)
      select_confirmation(current_recipient)
    when 'select_channel'
      current_recipient = select_recipient(workspace.channels)
      select_confirmation(current_recipient)
    when 'details'
      tp current_recipient
    when 'send_message'
      if (current_recipient.is_a? Member) || (current_recipient.is_a? Channel)
        send_message(current_recipient)
      else
        puts "No current recipient selected."
      end
    else
      puts "Looks like this isn't a valid option."
    end

    puts "What would you like to do next?"
    puts "Your options are: list_members, list_channels, or quit"
    user_action = gets.chomp.downcase
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

# what happens if username and channel name are the same?