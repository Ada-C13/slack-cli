require "httparty"
require "dotenv"
require 'json'
require_relative "recipient"

Dotenv.load


class Channel < Recipient

  attr_reader :topic, :memeber_count
  
  def initialize(topic:, memeber_count:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @memeber_count = memeber_count
  end

  def self.list_all
    data = Channel.get("https://slack.com/api/conversations.list")

    channels = []

    data["channels"].each do |channel|
      channels << Channel.new(
        name: channel["name"],
        slack_id: channel["id"],
        topic: channel["topic"]["value"],
        memeber_count: channel["num_members"])
    end
    return channels
  end
end