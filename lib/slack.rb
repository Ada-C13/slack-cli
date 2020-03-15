#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'
require 'colorize'
require 'terminal-table'

# Question: Is it a good practice to use WORKSPACE as constant?
WORKSPACE = Slack::Workspace.new

OPTIONS = {
  "1" => ["list users", "list user"],
  "2" => ["list channels", "list channel"],
  "3" => ["select user"],
  "4" => ["select channel"],
  "5" => ["details", "detail", "show details"],
  "6" => ["send message", "send", "message"],
  "7" => ["change settings", "change setting", "setting"],
  "8" => ["check message history", "message history", "message list", "list message"],
  "9" => ["quit", "exit", "q", "bye"]
}


def display_options 
  puts "\nChoose one of the following options:"

  OPTIONS.each do |number, option|
    puts "  #{number}. #{option[0].blue}" 
  end 
end 


def get_option
  print "\n > "
  option = gets.chomp.downcase 
  option = validate_option(option) 
  puts "\n"

  return option
end 


def validate_option(option) 
  while !OPTIONS.keys.include?(option) && !OPTIONS.values.flatten.include?(option)
    puts "  #{"⚠️  You chose a wrong option!😅 Try again".light_black}."
    print " > "
    option = gets.chomp.downcase
  end 
  return option
end 


def get_user_name 
  puts "Select a user name, a real name, or a slack id"
  print "> "
  name = gets.chomp
  name = validate_user_name(name) 

  return name
end 


def validate_user_name(name) 
  user = WORKSPACE.select_user(name) ##

  while user == nil
    puts "  #{"⚠️  No user found!😅 Try again".light_black}"
    print "> " 
    name = gets.chomp
    user = WORKSPACE.select_user(name) ##
  end 

  puts "  ✅ You've selected the user name, #{user.name.bold} - #{user.slack_id}"
  return name
end 


def get_channel_name 
  puts "Select a channel name or a slack id"
  print "> "
  name = gets.chomp
  channel = validate_channel_name(name) 

  puts "  ✅ You've selected the channel name, ##{channel.name.bold} - #{channel.slack_id}"

  return name
end 


def validate_channel_name(name)
  user = WORKSPACE.select_channel(name) ##

  while user == nil
    puts "No channel found!😅 Try again"
    print "> " 
    name = gets.chomp
    user = WORKSPACE.select_channel(name) ##
  end 

  return user
end 

def error_message 
  puts " #{"⚠️  No user or channel selected".light_black}"
  puts "    #{"After selecting one of them, try again!".light_black}"
end 


def display_details 
  details = WORKSPACE.show_details ##

  error_message if !details 

  details
end 


def get_recipient 
  WORKSPACE.selected.name if WORKSPACE.selected
end 


def get_message 
  recipient = "to #{get_recipient}"
  print "Enter your message #{recipient}"
  print " > "
  gets.chomp
end 


def validate_message(message)
  send_message = WORKSPACE.send_message(message)
  if !send_message
    error_message
  else 
    puts "  ✅ You've successfully sent a message to #{get_recipient}"
  end 
end 


def get_username 
  print "username > "
  gets.chomp
end 

def get_emoji 
  print "emoji > "
  gets.chomp
end 


def validate_setting(input, target)
  while input.empty?
    puts "  ⚠️  Invalid input. 😅 Try again"

    target == "username" ? input = get_username : input = get_emoji
  end
  return input
end 


def validate_history 
  message = WORKSPACE.message_history

  if !message 
    puts " #{"⚠️  No channel selected".light_black}"
    puts "    #{"After selecting a channel, try again!".light_black}"
    return false

  elsif message == "User selected"
    puts " #{"⚠️  Checking message history for `users` are not available at the moment".light_black}"
    puts "    #{"After selecting a channel, try again!".light_black}"
    return false
  end 

  return message
end 


def display_history 
  message = validate_history

  if message 
    puts "Here is #{get_recipient}'s message history below:"
    rows = WORKSPACE.selected.message_history(WORKSPACE.selected)
    table = Terminal::Table.new :headings => ['username', 'text'], :rows => rows
    puts table 
  end 
end 


def main
  puts "\nWelcome to the Ada Slack CLI!💬"
  workspace = Slack::Workspace.new

  puts "-------------------------"
  puts "##{workspace.users.length} users || ##{workspace.channels.length} channels" 
  puts "-------------------------"


  # TODO project

  display_options
  option = get_option

  continue = true 

  while continue 
    case option 
    when "1", *OPTIONS["1"] # list users
      WORKSPACE.list_users  ##
  
      display_options
      option = get_option

    when "2", *OPTIONS["2"]  # list channels 
      WORKSPACE.list_channels ##
  
      display_options
      option = get_option

    when "3", *OPTIONS["3"]  # select user
      get_user_name

      display_options
      option = get_option

    when "4", *OPTIONS["4"] # select channel
      get_channel_name

      display_options
      option = get_option

    when "5", *OPTIONS["5"]  # detail
      display_details 
      
      display_options
      option = get_option
 
    when "6", *OPTIONS["6"] # send message
      message = get_message
      validate_message(message)

      display_options
      option = get_option

    when "7", *OPTIONS["7"] # change settings
      username = get_username 
      username = validate_setting(username, "username")

      emoji = get_emoji
      emoji = validate_setting(emoji, "emoji")

      WORKSPACE.change_setting(username, emoji)
      puts "  ✅ You've successfuly changed profile settings!"

      display_options
      option = get_option

    when "8", *OPTIONS["8"] # check message history
      display_history

      display_options
      option = get_option

    when "9", *OPTIONS["9"] # quit
      puts "Bye 👋👋🏻👋🏼👋🏽👋🏾👋🏿"
      continue = false
    end 
  end 


  puts "\nThank you for using the Ada Slack CLI 😊"
end

main if __FILE__ == $PROGRAM_NAME