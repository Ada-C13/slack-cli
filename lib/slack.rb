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

@channels = list_channels
@members = list_members

def select_member
  puts "Please provide either a username or Slack ID:"
  user_input = gets.chomp.downcase
  
  member = find_member_object(user_input, @members)

  return member.nil? ? "Member does not exist" : member.real_name
end

def find_member_object(search_term, object_type)
  object_type.find {|object| 
    object.id == search_term || object.name == search_term}
end


def main
  puts "Welcome to the Ada Slack CLI!"

  puts "What would you like to do?"
  puts "Your options are: list_members, list_channels, select_user, select_channel, or quit"

  user_action = gets.chomp.downcase

  until user_action == 'quit'
    case user_action
    when 'list_members'
      puts "List of Members:"
      tp @members
    when 'list_channels'
      puts "List of Channels:"
      tp @channels
    when 'select_user'
      puts "You have selected: #{select_member}"
    else
      puts "Looks like this isn't a valid option."
    end

    puts "What would you like to do next?"
    puts "Your options are: list_members, list_channels, or quit"
    user_action = gets.chomp.downcase
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME