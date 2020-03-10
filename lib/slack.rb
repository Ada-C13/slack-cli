#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'channel'
require_relative 'member'
Dotenv.load

CHANNEL_URL = 'https://slack.com/api/channels.list'
MEMBER_URL = "https://slack.com/api/users.list"

def main
  puts "Welcome to the Ada Slack CLI!"
  # TODO project
  puts "What would you like to do?"
  puts "Your options are: list_members, list_channels, or quit"

  user_action = gets.chomp.downcase

  until user_action == 'quit'
    case user_action
    when 'list_members'
      puts "List of Members:"
      tp list_members
    when 'list_channels'
      puts "List of Channels:"
      tp list_channels
    else
      puts "Looks like this isn't a valid option."
    end

    puts "What would you like to do next?"
    puts "Your options are: list_members, list_channels, or quit"
    user_action = gets.chomp.downcase
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

# channel's name, topic, member count, and Slack ID.
def list_channels
  query_parameters = {
    token: ENV['SLACK_TOKEN']
  }

  response = HTTParty.post(CHANNEL_URL, query: query_parameters)["channels"]
  
  list_of_channels = response.map {|channel| 
    Channel.new(
      name: channel["name"],
      topic: channel["topic"]["value"],
      member_count: channel["members"].length,
      id: channel["id"]
    )
  }

  return list_of_channels
end

# username, real name, and Slack ID
def list_members
  query_parameters = {
    token: ENV['SLACK_TOKEN']
  }

  response = HTTParty.post(MEMBER_URL, query: query_parameters)["members"]
  
  list_of_members = response.map {|member| 
    Member.new(
      name: member["name"], 
      real_name: member["profile"]["real_name"], 
      id: member["id"]
    )
  }

  return list_of_members
end

main if __FILE__ == $PROGRAM_NAME