#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'

# helper method
def get_user_input
  puts "Choose an action from the following list:
  1. View Users => Enter: users
  2. View Channels => Enter: channels 
  3. Quit => Type: quit "
  return gets.chomp.upcase
end

def main
  workspace = SlackApi::Workspace.new
  puts "\n"
  puts "Welcome to the Ada Slack CLI!"
  puts "\n"
  puts "What would you like to do?"
  puts "\n"

    user_input = get_user_input
    puts "\n"

    while user_input != "QUIT"
      if user_input == "USERS"
        workspace.list_all_users
        puts "\n"
      elsif user_input == "CHANNELS"
        workspace.list_all_channels
        puts "\n"
      else 
        puts "Bad Entry: Try Again."
        puts "\n"
      end 
      user_input = get_user_input
      puts "\n"
    end
    puts "Thank you for using the Ada Slack CLI"
    puts "\n"
end

main if __FILE__ == $PROGRAM_NAME
