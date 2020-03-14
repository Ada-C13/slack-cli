#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "This workspace has #{workspace.users.length} users and #{workspace.channels.length} channels"

  # given three options for how to interact with the program:
  input = ""
  until input == "quit"
    puts "\nWhat would you like to do?"
    options = ["list users", "list channels", "select user", "select channel", "details", "quit"]

    options.each_with_index do |option, i|
      puts "#{i + 1}. #{option}"
    end

    input = gets.chomp.downcase

    case input
      when "1", "list users"
        puts workspace.users
      when "2", "list channels"
        puts workspace.channels
      when "3", "select user"
        print "\nProvide the username or Slack ID of the user you want to select: "
        user = gets.chomp.upcase

      when "4", "select channel"
        print "\nprovide the channel name or Slack ID of the channel you want to select: "
        channel = gets.chomp.upcase

      when "5", "details"

      when "6", "quit"
        input = "quit"
      else
        puts "That's not a valid option, please try again."
    end
  end

  # list users
  # list channels
  # quit
  # As a user who is at the program's input prompt...
  
  # When I type quit, the program should exit.
  # After completing any command other than quit, the program should reprint the list of commands and ask for another input.


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME