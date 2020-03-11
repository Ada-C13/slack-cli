#!/usr/bin/env rubycc
require "httparty"
require "dotenv"
require_relative "workspace"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  # Print users/channels
  puts "3 options: list users, list channels, or quit:"
  input = gets.chomp
  
  while input != "quit"
    # puts "you didn't quit"
    if input == "list users"
      puts workspace.users
    elsif input == "list channels"
      puts workspace.channels
    else 
      puts "try again"
    end
    puts "3 options: list users, list channels, or quit:"
    input = gets.chomp
  end



  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

