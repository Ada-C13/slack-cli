#!/usr/bin/env ruby
require_relative 'workspace'

#list users username, real name, and Slack ID.
#list channels name, topic, member count, and Slack ID.

def list_options
  puts "Please enter one of the followings:"
  puts "===================================="
  puts "list users"
  puts "list channels"
  puts "quit"
  puts "===================================="
end 

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  input = "not quit"
  # TODO project
  while input != "quit"
    list_options
    input = gets.chomp 

    if input == "list channels"
      puts "Cool, here are the channels..."
      p workspace.channels
    elsif  input == "list users"
      puts "Sweet, here are the users"
      p workspace.users
    else
      puts "not a valid input"
    end 
   
  end 
  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

