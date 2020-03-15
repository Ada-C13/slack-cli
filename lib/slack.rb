#!/usr/bin/env ruby
require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'channel'
require_relative 'user'
require_relative 'recipient'

Dotenv.load


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new


  def options 
    puts "Would you like to:
    list users
    list channels
    quit"
    return gets.chomp
  end
  

  user_selection = options # saves the gets.chomp of their options 

  
  def user_input(user_selection)  
    if user_selection == "list users"
      tp User.list_all
    elsif user_selection == "list channels"
      tp Channel.list_all
    elsif user_selection == "quit" || user_selection == "exit"
      closing
    end 
  end

  def closing
    puts "Thank you for using the Ada Slack CLI"
    exit
  end 

  user_input(user_selection) # will give direction on what methods to call 

  
#   def list_users
#     query = {
#       token: ENV["SLACK_API_TOKEN"]
#     }

#     url = "https://slack.com/api/users.list"
#     response = HTTParty.get(url, query: query)
#     #  puts response 
#     response["members"].each do |user|
#       puts "User info:
#         username: #{user["name"]}, 
#         real name: #{user["real_name"]}, 
#         id: #{user["id"]}"
#     end 
#   end

#   def list_channels
#     query = {
#       token: ENV["SLACK_API_TOKEN"]
#     }
    
#     url = "https://slack.com/api/channels.list"
#     response = HTTParty.get(url, query: query)
    
#     response["channels"].each do |channel|
#       puts "Channel info:
#         name: #{channel["name"]},
#         topic: #{channel["topic"]["value"]},
#         member count: #{channel["num_members"]},
#         id: #{channel["id"]},
#         "
#     end 
#   end

  

  # def closing
  #   puts "Thank you for using the Ada Slack CLI"
  # end 
end

main if __FILE__ == $PROGRAM_NAME