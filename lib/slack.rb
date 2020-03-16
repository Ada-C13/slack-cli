#!/usr/bin/env ruby
require 'httparty'
require_relative 'workspace'
require 'table_print'
require 'colorize'

def main
  workspace = Workspace.new
  puts "Welcome to the Ada Slack CLI! \nThere are #{workspace.users.count} users and #{workspace.channels.count} channels.".bold.magenta
  puts "\n"

  choice = init_user_options
  puts "\n"
  until choice == "quit"
    
    case choice
    when "list users"

      tp workspace.users, "real_name", "name", "slack_id"
      puts "\n"
      puts "What would you like to do?".bold.colorize(:cyan)
      puts "•Select user \n•Quit ".bold
      
      selection = gets.chomp.downcase
      case selection
      when "select user"

        puts "Please supply a username or Slack ID for the user".bold.colorize(:cyan)
        user = gets.downcase.chomp
        selected_user = workspace.select_user(user)
        puts "\n"

        if selected_user.is_a? User
          puts "You have selected user: #{workspace.selected.name}".bold.colorize(:magenta)
          puts "\n"

          puts "Would you like to see details about your selected user, send message to that user or quit?".bold.colorize(:cyan)
          puts "•Details \n•Send message \n•Quit ".bold
          choice = gets.chomp.downcase
          puts "\n"

          case choice
          when "details"
            tp workspace.show_details, "real_name", "slack_id", "status_text", "status_emoji"
            puts "\n"
          when "send message"
            puts "Please enter the message you would like to send".bold.colorize(:cyan)
            message = gets.chomp
            workspace.send_message(message)
            puts "\n"
          when "quit"
            exit
          else
            puts "That is not a valid response, please try again".colorize(:red).bold
            puts "\n"
          end
          
        elsif selected_user == "User not found!"
          puts "#{selected_user} Please try again!".colorize(:red).bold
          puts "\n"
          puts "\n"
        end
       
      when "quit"
        exit
      else
        puts "That is not a valid response, please try again".colorize(:red).bold
        puts "\n"
      end
    
    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
      puts "What would you like to do?".bold.colorize(:cyan)
      puts "•Select channel \n•Quit ".bold
      selection = gets.chomp.downcase

      case selection
      when "select channel"
        puts "Please supply a channel name of Slack ID for the channel".bold.colorize(:cyan)
        channel = gets.downcase.chomp
        selected_channel = workspace.select_channel(channel)
        puts "\n"

        if selected_channel.is_a? Channel
          puts "You have selected channel: #{workspace.selected.name}".bold.colorize(:magenta)
          puts "\n"

          puts "Would you like to see details about your selected channel, send message to that channel or quit?".bold.colorize(:cyan)
          puts "•Details \n•Send message \n•Quit ".bold
          choice = gets.chomp.downcase
          puts "\n"

          case choice
          when "details"
            tp workspace.show_details, "name", "slack_id", "member_count", "topic"
            puts "\n"
          when "send message"
            puts "Please enter the message you would like to send".bold.colorize(:cyan)
            message = gets.chomp
            workspace.send_message(message)
            puts "\n"
          when "quit"
            exit
          else
            puts "That is not a valid response, please try again".colorize(:red).bold
            puts "\n"
          end

        elsif selected_channel == "User not found!"
          puts "#{selected_channel} Please try again!".colorize(:red).bold
          puts "\n"
        end

      when "quit"
        exit
      else
        puts "That is not a valid response, please try again".colorize(:red).bold
        puts "\n"
      end
      
    when "quit"
      exit
    else
      puts "That is not a valid response, please try again".colorize(:red).bold
      puts "\n"
    end
    choice = init_user_options 
  end
  puts "Thank you for using the Ada Slack CLI".bold.colorize(:magenta)
end

def init_user_options
  puts "What would you like to do?".bold.colorize(:cyan)
  puts "•List users \n•List channels \n•Quit".bold
  choice = gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME