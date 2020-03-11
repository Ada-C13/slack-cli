require "httparty"
require "dotenv"
require "awesome_print"
require_relative "recipient"

Dotenv.load

class Channel < Recipient

  CHANNEL_LIST_URL = "https://slack.com/api/channels.list"
  KEY = ENV["SLACK_TOKEN"]

  def initialize(slack_id, name)
    super(slack_id, name)
  end

  def self.list_all
    query_parameters = {
      token: KEY
    } 
    response = HTTParty.get(CHANNEL_LIST_URL, query: query_parameters)

    channel_lists = []
    response["channels"].each do |channel|
       channel_info= {
        channel_name: channel["name"],
        topic: channel["topic"],
        member_count: channel["num_members"],
        slacl_id: channel["id"]
      }
      channel_lists << channel_info
    end
    return channel_lists
  end
end

ap Channel.list_all