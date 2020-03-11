#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require "awesome_print"
require_relative "workspace"

def main
  puts "Welcome to the Mair Bear's Slack CLI!"
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels and #{workspace.users.length} users in this Slack."

  while true
    puts "What would you like to do?"
    puts "\nlist users\nlist channels\nquit"
    options = ["list users", "list channels", "quit"]
    users_option = gets.chomp.downcase
    until options.include? users_option
      puts "Please input a valid command."
      users_option = gets.chomp.downcase
    end

    case users_option
    when "list users"
      ap workspace.users
    when "list channels"
      ap workspace.channels
    when "quit"
      break
    end
  end

  puts "Thank you for using the Mair Bear's Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
