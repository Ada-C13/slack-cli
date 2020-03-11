require 'httparty'
require 'dotenv'
require 'awesome_print'

require_relative 'recipient'

Dotenv.load

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list_all
    base_url = "https://slack.com/api/channels.list"
    query = {
      token: ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(base_url, query: query)
    channels = response["channels"]

    return channels.map { |channel| Channel.new(channel["id"], 
      channel["name"], channel["topic"]["value"], 
      channel["num_members"]) }

  end
end