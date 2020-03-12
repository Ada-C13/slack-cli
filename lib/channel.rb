require "httparty"
require "dotenv"
require "awesome_print"
require_relative "recipient"

Dotenv.load

CHANNEL_LIST_URL = "https://slack.com/api/channels.list"
KEY = ENV["SLACK_TOKEN"]

class Channel < Recipient
  
  attr_reader :topic, :member_count

  def initialize(id, name, topic, member_count)
    super(id, name)
  end

  def self.list_all
    query_parameters = {
      token: KEY
    } 
    response = self.get(CHANNEL_LIST_URL, query_parameters)

    channel_lists = []
    response["channels"].each do |channel|
       channel_info= {
        channel_name: channel["name"],
        topic: channel["topic"],
        member_count: channel["num_members"],
        slack_id: channel["id"]
      }
      channel_lists << channel_info
    end
    return channel_lists
  end
end

# ap Channel.list_all