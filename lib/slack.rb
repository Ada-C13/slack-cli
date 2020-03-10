#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'httparty'

def ask_again
  puts "Choose from the following: 
  1. list users
  2. list channels
  3. quit
  "
  input = gets.chomp.to_i

  return input
end 


def main
  workspace = Workspace.new()
  puts "Welcome to the Ada Slack CLI!"
  puts "Choose from the following: 
  1. list users
  2. list channels
  3. quit
  "
  input = gets.chomp.to_i
  while input != 3
    if input == 1
      puts workspace.list_users
      input = ask_again
    elsif input == 2
      puts workspace.list_channels
      input = ask_again
    else
      puts "idk"
      input = ask_again
    end 
  end 
  puts "Thank you for using the Ada Slack CLI"

  

end

main if __FILE__ == $PROGRAM_NAME