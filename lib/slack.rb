#!/usr/bin/env ruby
require "dotenv"
require "table_print"

Dotenv.load

require_relative "workspace"

def menu
  # should be able to do 3 things Wave 1
  puts "Menu"
  puts "1. List Channels"
  puts "2. List Users"
  puts "3. Quit"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  # i is set to negative -1
  # as long a user of the program doesn't chose to "quit" the program will countine to run thru the while loop
  # i will then become 1 which is more than 1 and will end the program

  ### need to rescue the Invalid Response error
  i = -1
  while i < 0
    puts "Your workspace has #{workspace.channels.length} channels and #{workspace.users.length} users."
    puts "--------------------"
    puts "What would you like to do? 'list channels', 'list users', or 'quit'"
      answer = gets.chomp.downcase
      begin
       if answer != "list channels" || answer != "user channels" || answer != "quit"
        raise StandardError.new "This exception will be rescued!"
      end 
      rescue StandardError => exception
        p exception.message
      end

        if answer == "list channels"
          # puts workspace.list_channels (method that shows channels)
          tp workspace.channels, :topic, :member_count
        elsif answer == "list users"
          # puts workspace.list_users
          tp workspace.users, :slack_id, :real_name, :name
        elsif answer == "quit"
          # need to quit
          i = 1
        end #if loop
     puts "Thank you for using the Ada Slack CLI"
  end #while loop
end # main

main if __FILE__ == $PROGRAM_NAME
#  unless answer == "list channels" || answer == "user channels" || answer == "quit"
#       raise Exception.new "Please enter a valid response"
# end
