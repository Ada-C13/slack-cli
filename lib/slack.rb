#!/usr/bin/env rubycc
require "httparty"
require "dotenv"
require "table_print"
require_relative "workspace"


Dotenv.load

def prompt_options
  puts "6 options: list users, list channels, select user, select channel, details, or quit:"
  input = gets.chomp.downcase
  return input
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  input = prompt_options
  while input != "quit" && input != "exit"
    case input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
    when "list channels"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
    when "select user"
      puts "Please provide user ID or username:"
      user_id_or_username = gets.chomp
      validate_user = workspace.select_user(user_id_or_username)
      puts "User doesn't exist!" if validate_user == nil
    when "select channel"
      puts "Please provide channel ID or channel name:"
      channel_id_or_channelname = gets.chomp
      validate_channel = workspace.select_channel(channel_id_or_channelname)
      puts "Channel doesn't exist!" if validate_channel == nil
    when "details"
      puts workspace.show_details
      puts "You haven't selected a user or channel." if workspace.show_details == ""
    else 
      puts "try again"
    end
    input = prompt_options
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME