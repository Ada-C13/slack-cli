#!/user/bin/env ruby
require "httparty"
require "awesome_print"
require "dotenv"
require 'table_print'
require 'colorized'
require_relative 'workspace'
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'
Dotenv.load

def check_selected(workspace)
  selected_user = nil
  select_channel = nil
  while selected_user.nil? && select_channel.nil?
    print "Please provide a name or Slack ID or hit Enter to exit => "
    input = gets.chomp.downcase
    if input == ''
      break
    end
    
    selected_user = workspace.select_user(input)
    select_channel = workspace.select_channel(input)

    if selected_user.nil? && select_channel.nil?
      puts "\nInvalid name or Slack ID".red
    else
      puts "\nYou've selected '#{workspace.selected.name}'".blue
    end
  end
end

def main
  begin
    workspace = SlackCLI::Workspace.new
  rescue SlackCLI::Recipient::SlackAPIError => error
    puts "\nSorry, #{error}\n".red
    exit
  end

  puts "\nWelcome to the Ada Slack CLI!".blue
  user_command = nil
  
  until user_command == 'quit' || user_command == '7' || user_command == '7.'
    puts "\nPlease choose one of the options: \n1. List users\n2. List channels\n3. Select user\n4. Select channel"
    puts "5. Details\n6. Send message\n7. Quit\n"
    user_command = gets.chomp.downcase

    begin
      case user_command
      when 'list users', '1', '1.'
        puts
        tp workspace.users, :slack_id, :name, :real_name
        puts

      when 'list channels', '2', '2.'
        puts
        tp.set :max_width, 60
        tp workspace.channels, :slack_id, :name, :topic, :member_count
        puts

      when 'select user', '3', '3.'
        check_selected(workspace)

      when 'select channel', '4', '4.'
        check_selected(workspace)

      when 'details', '5', '5.'
        if workspace.selected.nil?
          puts "\nYou need to select a user or a channel before choosing the Details option".red
        else
          puts workspace.show_details.blue
        end

      when 'send message', '6', '6.'
        if workspace.selected.nil?
          puts "\nYou need to select a user or a channel before sending a message".red
        else
          puts "What message do you want to send to the selected user/channel?"
          print "Type text or hit Enter to exit => "
          message = gets.chomp.downcase
          if message != ''
            begin
              workspace.selected.send_message(message)
              puts "\nMessage sent!".blue
            rescue SlackCLI::Recipient::SlackAPIError => error
              puts "\nMessage not sent. Sorry, #{error}\n".red
            end
          end       
        end
      end
    rescue SlackCLI::Recipient::SlackAPIError => error
      puts "Sorry, #{error}\n".red
    end
  end
  puts "\nThank you for using the Ada Slack CLI\n".blue
end

main if __FILE__ == $PROGRAM_NAME
