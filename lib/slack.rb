#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'
require 'colorize'
require 'terminal-table'

# Question: decide workspace or WORKSPACE
WORKSPACE = Slack::Workspace.new

OPTIONS = {
  "1" => ["list users", "list user"],
  "2" => ["list channels", "list channel"],
  "3" => ["select user"],
  "4" => ["select channel"],
  "5" => ["details", "detail"],
  "6" => ["send message", "send", "message"],
  "9" => ["quit", "exit", "q"]
}


def display_options 
  puts "\nChoose one of the following options:"

  OPTIONS.each do |number, option|
    puts "  #{number}. #{option[0].green}" 
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

  puts "  ✅ You've selected the user name, #{user.name.bold}"
  return name
end 


def get_channel_name 
  puts "Select a channel name or a slack id"
  print "> "
  name = gets.chomp
  user = validate_channel_name(name) 

  puts "  ✅ You've selected the channel name, ##{user.name.bold}"

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


def get_message 
  print "Enter your message > "
  gets.chomp
end 


def validate_message(message)
  send_message = WORKSPACE.send_message(message)
  if !send_message
    error_message
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
    when "1", "list users", "list user"
      WORKSPACE.list_users  ##
  
      display_options
      option = get_option

    when "2", "list channels", "list channel" 
      WORKSPACE.list_channels ##
  
      display_options
      option = get_option

    when "3", "select user" 
      get_user_name

      display_options
      option = get_option

    when "4", "select channel"
      get_channel_name

      display_options
      option = get_option

    when "5", "details", "detail"
      display_details 
      
      display_options
      option = get_option
 
    when "6", "send message", "send", "message"
      message = get_message
      validate_message(message)

      display_options
      option = get_option

    when "9", "quit", "exit", "q"
      puts "Bye 👋👋🏻👋🏼👋🏽👋🏾👋🏿"
      continue = false
    end 
  end 


  puts "\nThank you for using the Ada Slack CLI 😊"
end

main if __FILE__ == $PROGRAM_NAME