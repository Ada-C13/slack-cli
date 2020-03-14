#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "This workspace has #{workspace.users.length} users and #{workspace.channels.length} channels"

  # given three options for how to interact with the program:
  input = ""
  until input == "quit"
    puts "\nWhat would you like to do?"
    list_options

    input = gets.chomp.downcase

    case input
      when "1", "list users"
        tp workspace.users, :slack_id, :name, :real_name
      when "2", "list channels"
        tp workspace.channels, :slack_id, :name, :topic, :member_count
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


  puts "Thank you for using the Ada Slack CLI"
end

def list_options
    options = ["list users", "list channels", "select user", "select channel", "details", "quit"]

    options.each_with_index do |option, i|
      puts "#{i + 1}. #{option}"
    end
end

main if __FILE__ == $PROGRAM_NAME