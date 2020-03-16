require_relative "recipient"

CHANNEL_URL = "https://slack.com/api/channels.list"

class Channel < Recipient
  attr_reader :topic, :num_members

  def initialize(topic:, num_members:, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @num_members = num_members
  end

  def details
    tp self, "slack_id", "name", "topic", "member_count"
  end

  def self.list_all
    response = self.get(CHANNEL_URL)
    channels = []
    response["channels"].each do |channel|
      channels << Channel.new(
        topic: channel['topic']['value'],
        num_members: channel['num_members'],
        slack_id: channel['id'],
        name: channel['name']
      )
    end
    return channels
  end
end
