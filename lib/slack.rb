#!/usr/bin/env ruby
require 'httparty'
require_relative 'workspace'
require 'table_print'

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
        user = gets.downcase.chomp
        selected_user = workspace.select_user(user)

        if selected_user.is_a? User
          puts "You have selected user: #{workspace.selected.name}"

          puts "Would you like to see details about your selected user, send message to that user or quit?"
          puts "•Details \n•Send message \n•Return to Main Menu \n•Quit "
          choice = gets.chomp.downcase

          case choice
          when "details"
            tp workspace.show_details, "real_name", "slack_id", "status_text", "status_emoji"
          when "send message"
            puts "Please enter the message you would like to send"
            message = gets.chomp
            workspace.send_message(message)
          when "return to main menu"
            next
          when "quit"
            exit
          end
          
        elsif selected_user == "User not found!"
          puts "#{selected_user} Please try again!"
        end
       
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
        puts "\n"
        channel = gets.downcase.chomp

        selected_channel = workspace.select_channel(channel)

        if selected_channel.is_a? Channel
          puts "You have selected channel: #{workspace.selected.name}"
          puts "\n"

          puts "Would you like to see details about your selected channel, send message to that channel or quit?"
          puts "•Details \n•Send message \n•Return to Main Menu \n•Quit "
          puts "\n"
          choice = gets.chomp.downcase

          case choice
          when "details"
            tp workspace.show_details, "name", "slack_id", "member_count", "topic"
          when "send message"
            puts "Please enter the message you would like to send"
            message = gets.chomp
            workspace.send_message(message)
          when "return to main menu"
            choice = init_user_options
            puts "\n"
          when "quit"
            exit
          else
            puts "That is not a valid response, please try again"
          end

        elsif selected_channel == "User not found!"
          puts "#{selected_channel} Please try again!"
          puts "\n"
        end

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