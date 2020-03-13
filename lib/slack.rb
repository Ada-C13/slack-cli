#!/usr/bin/env ruby
require "table_print"
require "httparty"
require "table_print"

def menu
  # should be able to 3 things Wave 1
  #
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  i = -1
  while i < 0
    puts "Your workspace has #{num_channels} channels and #{num_users} users."
    puts "--------------------"
    puts "What would you like to do? 'list channels', 'list users', or 'quit'"
    answer = gets.chomp.downcase
    if answer == "list channels"
      # puts workspace.list_channels (method that shows channels)
    elsif answer == "list users"
      # puts workspace.list_users
    elsif answer == "quit"
      # need to quit
      i = 1
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
