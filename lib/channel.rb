require 'awesome_print'

require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    "Slack ID: #{@slack_id}\nName: #{@name}\nTopic: #{@topic}\nMember count: #{@member_count}"
  end

  def self.list_all
    response = Channel.get("https://slack.com/api/channels.list")
    channels = response["channels"]

    return channels.map { |channel| Channel.new(channel["id"], 
      channel["name"], channel["topic"]["value"], 
      channel["num_members"]) }

  end
end