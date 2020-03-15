require "httparty"
require "dotenv"
Dotenv.load

require_relative "workspace"
require_relative "recipient"
require_relative "user"
require_relative "channel"

BASE_URL = "https://slack.com/api/"
USERS_URL = "#{BASE_URL}users.list"
CHANNELS_URL = "#{BASE_URL}conversations.list"
POST_URL = "#{BASE_URL}chat.postMessage"

SLACK_TOKEN = ENV["SLACK_TOKEN"]

def menu
  puts "\nWhat would you like to do?"
  puts "(please, type your selection)"
  puts " >>> list users"
  puts " >>> list channels"
  puts " >>> select user"
  puts " >>> select channel"
  puts " >>> details"
  puts " >>> send message"
  puts " >>> quit"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "+++++++++++++++++++++++++++++"
  puts "Your workspace has #{workspace.users.count} users and #{workspace.channels.count} channels."
  
  menu
  input = gets.chomp

  while input != "quit"
    case input
    when "list users"
      puts workspace.list_users
    when "list channels"
      puts workspace.list_channels
    when "select user"
      puts "Please, provide user name or Slack ID"
      query = gets.chomp
      if workspace.select_user(query: query) == nil
        puts "No user found."
      else
        puts "User selected."
      end
    when "select channel"
      puts "Please, provide channel name or Slack ID"
      query = gets.chomp
      if workspace.select_channel(query: query) == nil
        puts "No channel found."
      else
        puts "Channel selected."
      end
    when "details" 
      puts workspace.selected ? workspace.selected.get_details : "Nothing selected."
    when "send message"
      if workspace.selected
        puts "Please, type your message."
        message = gets.chomp
        if message != ""
          workspace.selected.send_message(message: message)
          puts "Message sent."
        else
          puts "Your message was empty. Boring!"
        end
      else
        puts "No recipient selected."
      end
    when "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    else 
      puts "\nUnknown command."
    end

    menu
    input = gets.chomp
  end
end

main if __FILE__ == $PROGRAM_NAME