#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'workspace'
require 'table_print'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  puts "What would you like to do?"
  puts "•List users \n•List channels \n•Quit"
  choice = gets.chomp.downcase
  until choice == "quit"
    puts "What would you like to do?"
    puts "•List users \n•List channels \n•Quit"
    choice = gets.chomp.downcase

    case choice
    when "list users"
      #calll the method that will show all the users
      puts "What would you like to do?"
      puts "•Select user \n•Quit "
      selection = gets.chomp.downcase
      case selection
      when "select user"
        puts "Please supply a username of Slack ID for the user"
        user = gets.chomp.downcase

        #write code that finds the specific user

        # if user not found write code that lets the user know that there is no user (puts user not found) by that username or ID and return to the original request of list user etc.

        # if the user is found...
        puts "Would you like to see details about your selected user, send message to that user or quit?"
      
        puts "•Details \n•Send message \n•Quit "
        choice = gets.chomp.downcase

        case choice
        when "details"
          #put in the code that will show the details of the current selected user
          #If no recipient is currently selected, the program should let me know and return to the main command prompt.(user = nil?)
        when "send message"
          # put in the code that will allow them to send a message to that recipient
        when "quit"
          exit
        end
        
      when "quit"
        exit
      end
        
    when "list channnels"
      #call method that will show all the channels
      puts "What would you like to do?"
      puts "•Select channel \n•Quit "
      selection = gets.chomp.downcase
      case selection
      when "select channel"
        puts "Please supply a channel name of Slack ID for the channel"
        channel = gets.chomp.downcase

        #write code that finds the specific user

        # if user not found write code that lets the user know that there is no channel (puts channel not found) by that channel name or ID and return to the original request of list user etc.

        # if the user is found...
        puts "Would you like to see details about your selected channel or quit?"
      
        puts "•Details \n•Send message \n•Quit "
        choice = gets.chomp.downcase

        case choice
        when "details"
          #put in the code that will show the details of the current selected channel
          #If no recipient is currently selected, the program should let me know and return to the main command prompt.(channel = nil?)
        
        when "quit"
          exit
        end
        
      when "quit"
        exit
      end
      
    when "quit"
      exit
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME


BASE_URL = "https://slack.com/api/channels.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

params = {token: SLACK_TOKEN}
response = HTTParty.get(BASE_URL, query: params)

