#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'workspace'
require 'table_print'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI! \n There are #{User.list_all.count} users and #{Channel.list_all.count} channels."
  workspace = Workspace.new

  # TODO project
  
  choice = init_user_options
  until choice == "quit"
    
    case choice
    when "list users"

      tp User.list_all

      puts "What would you like to do?"
      puts "•Select user \n•Return to Main Menu \n•Quit "
      
      selection = gets.chomp.downcase
      case selection
      when "select user"
        puts "Please supply a username of Slack ID for the user"
        user = gets.chomp.downcase

        #write code that finds the specific user

        # if user not found write code that lets the user know that there is no user (puts user not found) by that username or ID and return to the original request of list user etc.

        # if the user is found...
        puts "Would you like to see details about your selected user, send message to that user or quit?"
        puts "•Details \n•Send message \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

        case choice
        when "details"
          #put in the code that will show the details of the current selected user
          #If no recipient is currently selected, the program should let me know and return to the main command prompt.(user = nil?)
        when "send message"
          # put in the code that will allow them to send a message to that recipient
        when "return to main menu"
          choice = init_user_options
        when "quit"
          exit
        end

        puts "Would you like to see details about your selected user, send message to that user or quit?"
        puts "•Details \n•Send message \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

      when "return to main menu"
        choice = init_user_options
      when "quit"
        exit
      else
        puts "That is not a valid response, please try again"
      end
    
    when "list channels"
      tp Channel.list_all

      puts "What would you like to do?"
      puts "•Select channel \n•Return to Main Menu \n•Quit "
      selection = gets.chomp.downcase

      case selection
      when "select channel"
        puts "Please supply a channel name of Slack ID for the channel"
        channel = gets.chomp.downcase

        #write code that finds the specific user

        # if user not found write code that lets the user know that there is no channel (puts channel not found) by that channel name or ID and return to the original request of list user etc.

        # if the user is found...
        puts "Would you like to see details about your selected channel, return to the main menu, or quit?"
        puts "•Details \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

        case choice
        when "details"
          #put in the code that will show the details of the current selected channel
          #If no recipient is currently selected, the program should let me know and return to the main command prompt.(channel = nil?)
        when "return to main menu"
          choice = init_user_options

        when "quit"
          exit
        else
          puts "That is not a valid response, please try again"
        end
        
        puts "Would you like to see details about your selected channel, return to the main menu, or quit?"
        puts "•Details \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

      when "return to main menu"
        choice = init_user_options
      when "quit"
        exit
      else
        puts "That is not a valid response, please try again"
      end
      
    when "quit"
      exit
    else
      puts "That is not a valid response, please try again"
    end
    choice = init_user_options 
  end
  puts "Thank you for using the Ada Slack CLI"
end

def init_user_options
  puts "What would you like to do?"
  puts "•List users \n•List channels \n•Quit"
  choice = gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME


BASE_URL = "https://slack.com/api/channels.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

params = {token: SLACK_TOKEN}
response = HTTParty.get(BASE_URL, query: params)

