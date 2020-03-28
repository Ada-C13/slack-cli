#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'workspace'

#try to place dotenv.load on first file that loads
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  input = nil
  # TODO project
  until input == 'quit'
    puts "\n What would you like to do? Choose one of the following numbers:"
    puts "\n 1. List channels \n 2. List users \n 3. Select Channel \n 4. Select User \n 5. Get details \n 6. Send message"
    puts "\n Or type QUIT to exit"
    
    input = gets.chomp
    begin
      case input
      when "1"
        tp workspace.channels, "slack_id", "name", "member_count", "topic"
      when "2"
        tp workspace.users, "slack_id", "name", "real_name", "status_text", "status_emoji"
      when "3"
        selected_channel = nil
        # selected_channel = workspace.select_channel
        while selected_channel.nil?
          puts "Please enter a channel name or ID"
          input = gets.chomp
          selected_channel = workspace.select_channel(input)
        end
        
      when "4"
        selected_user = nil
        while selected_user.nil?
          puts "\nPlease enter a user name or ID"
          input = gets.chomp
          selected_user = workspace.select_user(input)
        end
      when "5"
        if workspace.selected.nil?
          puts "\nPlease select a channel or user to view their details!"
        else
          puts workspace.show_details
          
        end
      when "6"
        if workspace.selected.nil?
          puts "\nPlease select a channel or user to send a message to! Or enter QUIT to exit"
        else
          puts "\nPlease enter your message"
          message = gets.chomp
          workspace.selected.send_message(message)
        end
      when "quit" || "QUIT" || "Quit"
        
        puts "Thank you for using the Ada Slack CLI"
      end
    end
  end
end

main if __FILE__ == $PROGRAM_NAME