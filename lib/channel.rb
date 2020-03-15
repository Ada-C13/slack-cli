require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'


Dotenv.load

class Channel < Recipient
  attr_reader :topic, :members

  def initialize(id:, name:, topic:, members:)
    super(id: id, name: name)
    @topic = topic
    @members = members
  end

  def details
    tp self, "id", "name", "topic", "members"
  end


  BASE_URL = "https://slack.com/api/channels.list?"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]
  
  def self.list_all
    channel_list = []
    response = get(BASE_URL)
  
    response["channels"].each do |channel|
      channel_list << new(
      name: channel["name"],
      id: channel["id"],
      topic: channel["topic"]["value"],
      members: channel["members"].length)
    end
    return channel_list
  end
end

