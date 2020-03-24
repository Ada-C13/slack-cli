#!/usr/bin/env ruby
# menu choice Ruby gem.
require "tty-prompt"
@prompt = TTY::Prompt.new

require 'colorize'

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

# To handle the user_input, display the tables,show_details and send messages.
def selector(user_input)
  case user_input
    when "List of users"
      # tp = To print the intances in a table.
      puts "\n"
      tp @workspace.users, :name, :real_name, :id
      puts "\n"
    when "List of channels"
      puts "\n"
      tp @workspace.channels, :name, :topic, :member_count, :id
      puts "\n"
    when "Select Channel"
      print "Please enter the channel name or ID: "
      user_selection = @workspace.select_channel
      if user_selection == nil 
        puts "Invalid entry - the channel does not exist.".red
      else
        puts "#{user_selection} Has been chose".blue
      end
      puts "\n"
    when "Select User"
      print "Please enter the channel name or ID: "
      user_selection = @workspace.select_user
      if user_selection == nil 
        puts "Invalid entry - the user does not exist.".red
      else
        puts "#{user_selection} Has been chose".blue
      end
      puts "\n"
    when "Details"
    
      if @workspace.selected == nil
        puts "\n"
        puts "Invalid entry - You selected an invalid channel or User."
      else
        puts "\n"
        @workspace.show_details
        user_input = nil
      end
   
    when "Send message"
      if @workspace.selected == nil
        puts "\n"
        puts "Invalid entry"
      else
        puts "\n"
        @workspace.selected.send_message(@workspace.selected.name)
        puts "Your message has been sent".blue
        user_input = nil
      end
    when "Exit"
      puts "Bye!! Thank you for using Ada slack CLI".yellow
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