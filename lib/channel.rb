require_relative "recipient"
require "httparty"
require "dotenv"
require "table_print"

class Channel < Recipient
  attr_accessor :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  # called in the workspace
  # in this list channel method we are calling on the Recipient
  def self.list_channels
    response = Recipient.get("channels.list")
    channel_list = []
    if response["ok"] != true
      raise SlackError, "There was an error. The error message is #{response["error"]}"
    else
      response["channels"].each do |channel|
        @slack_id = channel["id"]
        @name = channel["name"]
        @topic = channel["topic"]
        @member_count = channel["members"].length

        channel_list << Channel.new(@slack_id, @name, @topic, @member_count)
      end
    end
    return channel_list
  end
end
