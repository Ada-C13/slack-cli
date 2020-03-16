#!/usr/bin/env rubycc
require "httparty"
require "dotenv"
require "table_print"
require_relative "workspace"

Dotenv.load

def prompt_options
  puts "\nHere are the options:\n- List users\n- List channels\n- Select user\n- Select channel\n- Details\n- Send message\n- Quit"
  input = gets.chomp.downcase
  return input
end

def option_details(input, workspace)
  case input
  when "list users"
    tp workspace.users, "slack_id", "name", "real_name"
  when "list channels"
    tp workspace.channels, "slack_id", "name", "topic", "member_count"
  when "select user"
    puts "\nPlease provide user ID or username:"
    user_id_or_username = gets.chomp
    validate_user = workspace.select_user(user_id_or_username)
    if validate_user == nil
      puts "\nUser doesn't exist!"
    else
      puts "\n#{user_id_or_username} is now the selected recipient."
    end
  when "select channel"
    puts "\nPlease provide channel ID or channel name:"
    channel_id_or_channelname = gets.chomp
    validate_channel = workspace.select_channel(channel_id_or_channelname)
    if validate_channel == nil
      puts "\nChannel doesn't exist!"
    else
      puts puts "\n#{channel_id_or_channelname} is now the selected recipient."
    end
  when "details"
    if workspace.show_details == ""
      puts "\nYou haven't selected a user or channel."
    else
      puts workspace.show_details
    end
  when "send message"
    if workspace.selected == ""
      puts "\nYou haven't selected a user or channel."
    else
      puts "\nPlease type in the message that you want to send to the selected recipient:"
      message = gets.chomp
      recipient = workspace.selected
      recipient.send_message(message)
    end
  else 
    puts "\nThis is not an option. Please try again."
  end
  return input
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  input = prompt_options
  while input != "quit" && input != "exit"
    option_details(input, workspace)
    input = prompt_options
  end
  puts "\nThank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME