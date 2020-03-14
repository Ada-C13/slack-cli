#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'workspace'
require 'table_print'
Dotenv.load

def main
  workspace = Workspace.new
  puts "Welcome to the Ada Slack CLI! \n There are #{workspace.users.count} users and #{workspace.channels.count} channels."
  
  # TODO project
  
  choice = init_user_options
  puts "\n"
  until choice == "quit"
    
    case choice
    when "list users"

      tp workspace.users, "real_name", "name", "slack_id"

      puts "\n"
      puts "What would you like to do?"
      puts "•Select user \n•Return to Main Menu \n•Quit "
      
      selection = gets.chomp.downcase
      case selection
      when "select user"
        puts "Please supply a username or Slack ID for the user"
        user = gets.chomp.downcase
        selected_user = workspace.select_user(user)

        if selected_user.is_a? User
          puts "You have selected user: #{workspace.selected.name}"
        elsif selected_user == "User not found!"
          puts "#{selected_user} Please try again!"
          puts "Please supply a username or Slack ID for the user"
          user = gets.chomp.downcase
          seleted_user = workspace.select_user(user)
        end
       
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
          puts "\n"
        when "quit"
          exit
        end

        # puts "Would you like to see details about your selected user, send message to that user or quit?"
        # puts "•Details \n•Send message \n•Return to Main Menu \n•Quit "
        # choice = gets.chomp.downcase

      when "return to main menu"
        choice = init_user_options
        puts "\n"
      when "quit"
        exit
      else
        puts "That is not a valid response, please try again"
      end
    
    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
      puts "What would you like to do?"
      puts "•Select channel \n•Return to Main Menu \n•Quit "
      selection = gets.chomp.downcase

      case selection
      when "select channel"
        puts "Please supply a channel name of Slack ID for the channel"
        channel = gets.chomp.downcase

        selected_channel = workspace.select_channel(channel)

        if selected_channel.is_a? Channel
          puts "You have selected channel: #{workspace.selected.name}"
        elsif selected_channel == "User not found!"
          puts "#{selected_channel} Please try again!"
          puts "Please supply a channel name or Slack ID for the channel"
          channel = gets.chomp.downcase
          seleted_channel = workspace.select_channel(channel)
        end
        
        puts "Would you like to see details about your selected channel, return to the main menu, or quit?"
        puts "•Details \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

        case choice
        when "details"
          #put in the code that will show the details of the current selected channel
          #If no recipient is currently selected, the program should let me know and return to the main command prompt.(channel = nil?)
        when "return to main menu"
          choice = init_user_options
          puts "\n"
        when "quit"
          exit
        else
          puts "That is not a valid response, please try again"
        end
        
        puts "Would you like to see details about your selected channel, return to the main menu, or quit?"
        puts "•Details \n•Return to Main Menu \n•Quit "
        choice = gets.chomp.downcase

      when "return to main menu"
        selection = init_user_options
        puts "\n"
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

