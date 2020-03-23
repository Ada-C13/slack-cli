#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'

WORKSPACE = Workspace.new

def main
  puts "Welcome to the Ada Slack CLI!"

  puts "This workspace has #{WORKSPACE.users.length} users and #{WORKSPACE.channels.length} channels"

  input = ""
  until input == "quit"
    puts "\nWhat would you like to do?"
    list_options
    input = gets.chomp.downcase

    case input
      when "1", "list users"
        list_users
      when "2", "list channels"
        list_channels
      when "3", "select user"
        select_user
      when "4", "select channel"
        select_channel
      when "5", "details"
        show_details
      when "6", "send message"
        send_message
      when "7", "customize bot"
        customize_bot
      when "8", "quit"
        input = "quit"
      else
        puts "That's not a valid option, please try again."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

def list_options
  options = ["list users", "list channels", "select user", "select channel", "details", "send message", "customize bot", "quit"]
  options.each_with_index do |option, i|
    puts "#{i + 1}. #{option}"
  end
end

def send_message
  if WORKSPACE.selected == ""
    puts "Please select a recipient before sending a message."
    return
  end

  message = ""
  until message != ""
    puts "Enter the message you would like to send to the selected recipient: "
    message = gets.chomp
  end
  WORKSPACE.selected.send_message(message)
end

def list_users
  tp WORKSPACE.users, :slack_id, :name, :real_name
end

def list_channels
  tp WORKSPACE.channels, :slack_id, :name, :topic, :member_count
end

def select_user
  print "\nProvide the name or Slack ID of the user you want to select: "
  WORKSPACE.select_user(gets.chomp.upcase)
  puts "No match found." if WORKSPACE.selected == ""
end

def select_channel
  print "\nProvide the name or Slack ID of the channel you want to select: "
  WORKSPACE.select_channel(gets.chomp.upcase)
  puts "No match found." if WORKSPACE.selected == ""
end

def show_details
  puts "Please make a selection first" if !WORKSPACE.show_details
end

def customize_bot
  print "Enter a new name for the bot: "
  new_bot_name = gets.chomp
  print "Enter a new status emoji for the bot (Syntax > :emoji_name:): "
  new_status_emoji = gets.chomp
  WORKSPACE.customize_bot(new_bot_name, new_status_emoji)
end

main if __FILE__ == $PROGRAM_NAME