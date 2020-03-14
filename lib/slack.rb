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

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  user_command = nil

  until user_command == 'quit' || user_command == '7' || user_command == '7.'
    puts "Please choose one of the options: \n1. List users\n2. List channels\n3. Select user\n4. Select channel"
    puts "5. Details\n6. Send message\n7. Quit"
    user_command = gets.chomp.downcase  
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
      selected_user = nil
      while selected_user.nil?
        print "Please provide a username or Slack ID or hit Enter to exit => "
        user = gets.chomp.downcase
        if user == ''
          break
        end
        selected_user = workspace.select_user(user)
        if selected_user.nil?
          puts "\nInvalid username or Slack ID".red
        else
          puts "\nYou've selected a user with Slack ID #{workspace.selected.slack_id}".blue
        end
      end
    when 'select channel', '4', '4.'
      selected_channel = nil
      while selected_channel.nil?
        print "Please provide a channel name or Slack ID or hit Enter to exit => "
        channel = gets.chomp.downcase
        if channel == ''
          break
        end
        selected_channel = workspace.select_channel(channel)
        if selected_channel.nil?
          puts "\nInvalid channel name or Slack ID".red
        else
          puts "\nYou've selected a channel with Slack ID #{workspace.selected.slack_id}".blue
        end
      end
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
          if  workspace.selected.send_message(message)
            puts "\nMessage sent!\n".blue
          else
            puts "\nMessage not sent\n".red
          end
        end       
      end
    end
  end

  puts "Thank you for using the Ada Slack CLI".blue
end

main if __FILE__ == $PROGRAM_NAME
