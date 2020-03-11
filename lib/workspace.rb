require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

require_relative 'channel'
require_relative 'member'
Dotenv.load

class Workspace
  attr_reader :users, :channels

  CHANNEL_URL = 'https://slack.com/api/channels.list'
  MEMBER_URL = 'https://slack.com/api/users.list'
  TOKEN = ENV['SLACK_TOKEN']

  def initialize
    @users = Member.all
    @channels = list_channels
  end

# channel's name, topic, member count, and Slack ID.
  def list_channels
    query_parameters = {
      token: TOKEN
    }

    response = HTTParty.get(CHANNEL_URL, query: query_parameters)["channels"]
    
    response.map {|channel| 
      Channel.new(
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["members"].length,
        id: channel["id"]
      )
    }
  end
end