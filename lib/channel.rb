require_relative "recipient"

class Channel < Recipient
  attr_accessor :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  # called in the workspace
  # in this list channel method we are calling on the Recipient

  def details
    return "Channel name:#{name}","Slack ID: #{slack_id}", "Topic:#{topic}", "Member count:#{member_count}"
  end

  def self.list_channels
    response = Recipient.get("channels.list")

    unless response["ok"] == true
      raise SlackError, "There was an error. The error message is #{response["error"]}"
    end

    channel_list = response["channels"].map do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]
      member_count = channel["members"].length

      Channel.new(slack_id, name, topic, member_count)
    end
    return channel_list
  end
end
