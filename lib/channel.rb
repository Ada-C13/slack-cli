require_relative 'recipient'

class Channel < Recipient
  attr_reader :member_count, :topic

  def initialize(slack_id:, name:, member_count:, topic:)
    super(slack_id: slack_id, name: name)
    @member_count = member_count
    @topic = topic
  end

  def self.list_all
    url = "https://slack.com/api/channels.list"
    response = Recipient.get(url)
    channels = response["channels"].map do |channel|
      name = channel["name"]
      slack_id = channel["id"]
      member_count = channel["members"].length
      topic = channel["topic"]["value"]
      Channel.new(slack_id: slack_id, name: name, member_count: member_count, topic: topic)
    end

    return channels
  end

  def details
    info = "Channel name: #{name}, Slack ID: #{slack_id}, Topic: #{topic}, Member Count: #{member_count}"
    puts info
    return info
  end
end