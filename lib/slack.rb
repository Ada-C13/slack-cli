#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require_relative'workspace'
require 'table_print'

Dotenv.load

unless ENV['SLACK_TOKEN']
  puts "Could not load API key, please store in the environment variable 'SLACK_API_TOKEN'"
  exit
end

def display_options 
  i = 1
    ["list users", "list channels", "quit"].each do |option|
      puts "#{i}. #{option}" 
      i +=1
    end
end

def main
  puts "Welcome to the Ada Slack CLI!"
 
  workspace = Workspace.new #create a new workspace object
  list_users = workspace.users
  specific_keys_list_users = list_users.map do |user|
    {
      "id" => user["id"],
      "real_name" => user["real_name"], 
      "username" => user["name"]
    }
  end

  list_channels = workspace.channels
 
  specific_keys_list_channels = list_channels.map do |channel|
    {
      "id" => channel["id"],
      "name" => channel["name"],
      "topic" => channel["topic"],
      "members" => channel["members"]
      
    }
  end

  should_countine = true 
  while should_countine
    puts "There are #{list_channels.count} channels and #{list_users.count} users"
    puts "How would you like to interact with the program?"
    display_options 
    
    # Get the user input 
    user_input = gets.chomp
    # Validate the user input
    until ["list users", "list channels", "quit"].include?(user_input)
      puts "You have provided an invalid option that is not listed, please try gain"  
      user_input = gets.chomp
    end

    if user_input == "list users"
      puts "Here is the list of users: #{specific_keys_list_users}" 
    elsif user_input == "list channels"
      puts "Here is the list of channels #{specific_keys_list_channels}"
    elsif user_input == "quit"
      break
    end
  end
  puts "Thank you for using the Ada Slack CLI"
  
end

main if __FILE__ == $PROGRAM_NAME

# As a user of the CLI program, I can list users and channels | ✔️?
# As a user of the CLI program, I can select users and channels | ✔️?
# As a user of the CLI program, I can show the details of a selected user or channel | ✔️?
# As a user of the CLI program, when I input something inappropriately, the program runs without crashing |