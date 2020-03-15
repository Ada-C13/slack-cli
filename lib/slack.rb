#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'workspace.rb'
require_relative 'channel.rb'
require_relative 'recipient.rb'
require_relative 'user.rb'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  list_options

  choice = get_user_input

  loop_through_choices(workspace,choice)

  puts "Thank you for using the Ada Slack CLI"
end

def list_options
  puts "Please enter one of the following options: list users, list channels, select user, select channel, details, send message, or quit"
end

def get_user_input
  user_input = gets.chomp
  options = ["list users", "list channels", "quit", "select user", "select channel", "details", "send message"]

  until options.include?(user_input)
    puts "Sorry, I don't recognize that option. Please type list users, list channels, or quit"
    user_input = gets.chomp
  end

  return user_input
end

def loop_through_choices(workspace, choice)
  chosen_user = nil
  chosen_channel = nil
  until choice == "quit"
    case choice
    when "list channels"
      # tp workspace.channels
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
    when "list users"
      # tp workspace.users
      tp workspace.users, "slack_id", "name", "real_name" 
      puts "\n"
    when "select user"
      chosen_user = select_user(workspace)
      chosen_channel = nil
    when "select channel"
      chosen_channel = select_channel(workspace)
      chosen_user = nil
    when "details"
      if chosen_user != nil
        tp chosen_user.details
      elsif chosen_channel != nil
        tp chosen_channel.details
      else
        puts "sorry, you don't have a user or channel selected currently"
      end
    when "send message"
      break if chosen_channel == nil && chosen_user == nil
      puts "What's the message?"
      message = gets.chomp
      send_msg_to = chosen_user ? chosen_user : chosen_channel
      send_msg_to.send_message(message)
    end

    puts "................."
    list_options
    choice = get_user_input
  end
end


def select_user(workspace)
  puts "Please enter the username or Slack ID of the user you want to select"
  inputted_user_info = gets.chomp
  chosen_user = ""
  search_by_username = workspace.users.find{ |user| user.name == inputted_user_info}
  search_by_id = workspace.users.find{ |user| user.slack_id == inputted_user_info}
  if search_by_username != nil
    chosen_user = search_by_username
  elsif search_by_id != nil
    chosen_user = search_by_id
  else
    puts "Sorry, that's not a valid username or slack ID"
  end

  return chosen_user
end

def select_channel(workspace)
  puts "Please enter the name or Slack ID of the channel you want to select"
  inputted_channel_info = gets.chomp
  chosen_channel = ""
  search_by_name = workspace.channels.find{ |channel| channel.name == inputted_channel_info}
  search_by_id = workspace.channels.find{ |channel| channel.slack_id == inputted_channel_info}
  if search_by_name != nil
    chosen_channel = search_by_name
  elsif search_by_id != nil
    chosen_channel = search_by_id
  else
    puts "Sorry, that's not a valid channel name or slack ID"
  end

  return chosen_channel
end

main if __FILE__ == $PROGRAM_NAME

