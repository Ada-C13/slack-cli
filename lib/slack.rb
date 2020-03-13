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

  until choice == "quit"
    if choice == "list channels"
      tp workspace.channels
    elsif choice == "list users"
      tp workspace.users
    end
    puts "................."
    list_options
    choice = get_user_input
  end




  puts "Thank you for using the Ada Slack CLI"
end

def list_options
  puts "Please enter one of the following options: list users, list channels, or quit"
end

def get_user_input
  user_input = gets.chomp
  options = ["list users", "list channels", "quit"]

  until options.include?(user_input)
    puts "Sorry, I don't recognize that option. Please type list users, list channels, or quit"
    user_input = gets.chomp
  end

  return user_input
end

main if __FILE__ == $PROGRAM_NAME

