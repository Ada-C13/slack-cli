#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'
require 'colorize'

OPTIONS = {
  "1" => ["list users", "list user"],
  "2" => ["list channels", "list channel"],
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
    puts "You chose a wrong option!😅 Try again."
    print "> "
    option = gets.chomp.downcase
  end 
  return option
end 


# Question
# Is it good to put in "slack.rb" or "workspace.rb?

# reference: http://tableprintgem.com/
def list_users(workspace)
  tp workspace.users, :name, :real_name, :slack_id
end 

def list_channels(workspace)
  tp workspace.channels, :name, :topic, :member_count, :slack_id
end 


def main
  puts "Welcome to the Ada Slack CLI!💬"
  workspace = Slack::Workspace.new

  # TODO project

  display_options
  option = get_option

  continue = true 

  while continue 
    case option 
    when "1", "list users", "list user"
      # workspace.list_users
      list_users(workspace)
  
      display_options
      option = get_option

    when "2", "list channels", "list channel" 
      # workspace.list_channels
      list_channels(workspace)
  
      display_options
      option = get_option

    when "9", "quit", "exit", "q"
      puts "Bye 👋🏼👋🏼👋🏼👋🏼"
      continue = false
    end 
  end 


  puts "\nThank you for using the Ada Slack CLI 😊"
end

main if __FILE__ == $PROGRAM_NAME