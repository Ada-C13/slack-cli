#!/usr/bin/env ruby
require "awesome_print"
require 'table_print'
require_relative "workspace"


def ask_for_action
  puts "* Select from the options below:"
  puts "* list users"
  puts "* list channels"
  puts "* select user"
  puts "* select channel"
  puts "* details"
  puts "* quit" 
  puts
end

def user_selected?(workspace)
  puts "Enter a username or Slack ID:"
  identifier = gets.chomp
  user = workspace.select_user(identifier)
  if user
    return "user #{identifier} selected"
  else
    return "user #{identifier} was not found"
  end
end

def channel_selected?(workspace)
  puts "Enter a channel name or Slack ID:"
  identifier = gets.chomp
  channel = workspace.select_channel(identifier)
  if channel
    return "channel #{identifier} selected"
  else
    return "channel #{identifier} was not found"
  end
end

def perform_action(action, workspace)
  case action
  when "list users"
    workspace.list_users
  when "list channels"
    workspace.list_channels
  when "select user"
    user_selected?(workspace)
  when "select channel"
    channel_selected?(workspace)
  when "details"
    workspace.show_details 
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "Number of users loaded = #{workspace.users.length}" 
  puts "Number of channels loaded = #{workspace.channels.length}"
  puts
  ask_for_action
  action = gets.chomp.downcase
  until action == "quit"
    puts perform_action(action, workspace)
    puts
    ask_for_action
    action = gets.chomp.downcase
  end
  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME