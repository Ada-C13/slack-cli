#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'workspace'
require 'table_print'

Dotenv.load

def main
  workspace = SlackCli::Workspace.new(users: SlackCli::User.list_all,channels: SlackCli::Channel.list_all,selected: nil)
  puts "Welcome to the Ada Slack CLI!"
  option = ' ' 
  while option != "quit"
    puts "What would you like to do?"
    puts "options: list channels? list users? select user? select channel? list details? send message? quit?" 
    option = gets.chomp
    unless option == "list channels" || option == "list users" || option == "select user" || option == "select channel" || option == "list details" || option == "send message" || option == "quit"
      puts "wrong input! try again!"
      puts "What would you like to do next?"
      puts "options: list channels? list users? select user? select channel? list details? send message? quit?"
      option = gets.chomp
    end

      case  option 
      when "list channels"
        puts ''
        tp workspace.channels.map{|channel| channel.details}, "slack_id", "name", "topic", "member_count" 
        puts ''
      when "list users"
        tp workspace.users.map{|user| user.details}, "slack_id", "name", "real_name", "status_text" ,"status_emoji" 
      when "select user"
        workspace.select_user
      when "select channel"
        workspace.select_channel
      when "send message"
        workspace.send_message
      when "list details"
        if workspace.selected == nil || workspace.selected == ''
          puts "no previously selected user or channel!"
          puts "would you like to select a user or a channel? q to return to previous menu!"
          selection = gets.chomp
          if 
            selection == "q"
            main
          elsif
            selection == "user"
            workspace.select_user
            puts "here are the details of user #{workspace.selected.name}"
            workspace.show_details
          elsif  selection == "channel"
            workspace.select_channel
            puts "here are the details of channel #{workspace.selected.name}"
            workspace.show_details
          else 
            puts "wrong input! try again"
            main
          end
        else 
          if
            selection == "user"
              puts "here are the details of user #{workspace.selected.name}"
              workspace.show_details
            elsif  selection == "channel"
              puts "here are the details of channel #{workspace.selected.name}"
              workspace.show_details
            else 
              puts "wrong input! try again"
              main
          end
        end
      when "quit"
        puts "Thank you for using the Ada Slack CLI"
      end
    end
end


main if __FILE__ == $PROGRAM_NAME