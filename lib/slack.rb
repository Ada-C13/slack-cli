#!/usr/bin/env ruby
require "dotenv"
require "pry"
require "httparty"

Dotenv.load

require_relative "workspace"
require_relative "user"
require_relative "channel"

def menu
  # should be able to 3 things Wave 1
  puts "Menu"
  puts "1. List Channels"
  puts "2. List Users"
  puts "3. Quit"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  # i is set to negative -1
  # as long a user of the program doesn't chose to "quit" the program
  # it will countine to loop thru everything until a user quits
  i = -1
  while i < 0
    puts "Your workspace has #{workspace.channels.length} channels and #{workspace.users.length} users."
    puts "--------------------"
    puts "What would you like to do? 'list channels', 'list users', or 'quit'"
    answer = gets.chomp.downcase
     unless answer == "list channels" || answer == "user channels" || answer == "quit"
      raise Exception.new "Please enter a valid response"
    if answer == "list channels"
      # puts workspace.list_channels (method that shows channels)
      puts workspace.list_channels
    elsif answer == "list users"
      # puts workspace.list_users
      puts workspace.list_users
    elsif answer == "quit"
      # need to quit
      i = 1
    end #if loop
    puts "Thank you for using the Ada Slack CLI"
  end #while loop
end # main
end
main if __FILE__ == $PROGRAM_NAME

#  unless answer == "list channels" || answer == "user channels" || answer == "quit"
#       raise Exception.new "Please enter a valid response"
# end
