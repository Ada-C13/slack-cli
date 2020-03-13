#!/usr/bin/env ruby
require_relative 'workspace'

def list_users(workspace)
  workspace.users.each do |user|
    user.details
  end
end

def list_channels(workspace)
  workspace.channels.each do |channel|
    channel.details
  end
end


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  
  puts "Choose an option
  - list users
  - list channels
  - quit"
  print "=> "
  user_option = gets.chomp

  case user_option
  when "list users"
    list_users(workspace)
  when "list channels"
    list_channels(workspace)
  when "quit"
    exit
  end

  main

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME