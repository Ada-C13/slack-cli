#!/usr/bin/env ruby
require_relative "workspace"
require_relative "recipient"
require_relative "user"
require_relative "channel"

def menu
  puts "\nWhat would you like to do?"
  puts "(please, type your selection)"
  puts " >>> list users"
  puts " >>> list channels"
  puts " >>> quit"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "+++++++++++++++++++++++++++++"
  puts "Your workspace has #{workspace.users.count} users and #{workspace.channels.count} channels."
  
  menu
  input = gets.chomp

  while input != "quit"
    case input
    when "list users"
      puts workspace.list_users
    when "list channels"
      puts workspace.list_channels
    when "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    else 
      puts "Unknown command."
    end

    menu
    input = gets.chomp
  end

  # TODO project
end

main if __FILE__ == $PROGRAM_NAME