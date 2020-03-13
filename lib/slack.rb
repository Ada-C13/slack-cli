# !/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'

Dotenv.load

def get_user_choice
  puts "Welcome to the Ada Slack CLI!"
  print "Please select one of the options: 
  (1) list users
  (2) list channels
  (3) quit
  \n Selection: "


  action = gets.chomp

  puts ""

  return action
end

def main
  # main code layout inspired by instructor solar system implementation
  program_running = true

  

  while (program_running)

    user_choice = get_user_choice

    case user_choice.downcase
    when "list users", "1"
      puts "list users not implemented yet"
      #TODO list all users in Slack workspace
      # has username, real name, and Slack ID
    
    when "list channels", "2"
      #TODO list all channels
      # include channel name, topic, member count, and Slack ID
      url = "https://slack.com/api/channels.list"
      workspace = Workspace.new
    
      query_parameters = {
        token: ENV['SLACK_API_TOKEN']
      }

      response = HTTParty.get(url, query: query_parameters)

           

      channels = response["channels"].map do |channel|
        puts channel["name"]
        puts channel["topic"]
        puts (channel["members"]).length
        puts channel["id"]
        # ["name"]
      end
      
    
    when "quit", "3"
      program_running = false
      puts "Thank you for using the Ada Slack CLI"
    else
      puts "Invalid selection. Please provide a valid action."
    end
  end
end



main if __FILE__ == $PROGRAM_NAME