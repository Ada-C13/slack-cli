#!/usr/bin/env ruby
# menu choice Ruby gem.
require "tty-prompt"
@prompt = TTY::Prompt.new

require "dotenv"
require "httparty"
require "awesome_print"
require "table_print"

require_relative 'workspace'
Dotenv.load

#  Promt gem @promt -> Using the gem 
def get_user_input
  user_input = @prompt.select('What do you want to do:') do |menu|
    # Each menu is assign to the varibale user_input > Depends of the user choise.
      menu.choice "List of users"
      menu.choice "List of channels"
      menu.choice "Select Channel"
      menu.choice "Select User"
      menu.choice "Details"
      menu.choice "Send message"
      menu.choice "Exit"
  end
  return user_input
end
# To handle the user_input and display the tables.
def selector(user_input)
  case user_input
    when "List of users"
      # tp = To print the intances in a table.
      tp @workspace.users, :name, :real_name, :id
    when "List of channels"
      tp @workspace.channels, :name, :topic, :member_count, :id
    when "Select Channel"
      print "Please enter the channel name or ID: "
      user_selection = @workspace.select_channel
      if user_selection == nil 
        puts "Invalid"
      else
        puts "#{user_selection} Has been chose"
      end
    when "Select User"
      print "Please enter the channel name or ID: "
      user_selection = @workspace.select_user
      if user_selection == nil 
        puts "Invalid"
      else
        puts "#{user_selection} Has been chose"
      end
    when "Details"
      if @workspace.selected == nil
        puts "Invalid entry"
      else
        @workspace.show_details
        user_input = nil
      end
    when "Send message"
      if @workspace.selected == nil
        puts "Invalid entry"
      else
        @workspace.selected.send_message(@workspace.selected.name)
        user_input = nil
      end
    when "Exit"
      exit
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  # Creates a new intance of workspace.
  @workspace = Slack_cli::Workspace.new
  
  user_input = nil
  while true
    user_input = get_user_input
    selector(user_input)
  end
end

main if __FILE__ == $PROGRAM_NAME