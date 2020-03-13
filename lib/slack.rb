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
  puts "Please choose one of the options: \n1. List users\n2. List channels\n3. Select user\n4. Select channel"
  puts "5. Details.\n6. Quit"

  user_command = gets.chomp.downcase
  until user_command == 'quit' || user_command == '6' || user_command == '6.'
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
      print "Please provide a username or Slack ID => "
      user = gets.chomp.downcase
      puts
      workspace.select_user(user)
      puts "You've selected user with Slack ID #{workspace.selected.slack_id}".blue
    when 'select channel', '4', '4.'
      print "Please provide a channel name or Slack ID => "
      channel = gets.chomp.downcase
      puts
      selected = workspace.select_channel(channel)
      puts "You've selected channel with Slack ID #{workspace.selected.slack_id}".blue
    when 'details', '5', '5.'
      if workspace.selected.nil?
        puts "\nYou haven't selected a user or a channel".blue
      else
        puts workspace.show_details.blue
      end
    end
    puts "\nChoose your option:  \n1. List users\n2. List channels\n3. Select user\n4. Select channel"
    puts "5. Details.\n6. Quit\n"
    user_command = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
