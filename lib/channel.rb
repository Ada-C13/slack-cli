require_relative 'recipient'

class Channel < Recipient
  attr_reader :member_count, :topic

  def initialize(slack_id:, name:, member_count:, topic:)
    super(slack_id: slack_id, name: name)
    @member_count = member_count
    @topic = topic
  end

  def details
    tp self, "name", "topic", "slack_id", "member_count"
    return self
  end

  def self.list_all
    data = self.get("https://slack.com/api/conversations.list")
    channels = data["channels"].map do |channel|
      name = channel["name"]
      slack_id = channel["id"]
      member_count = channel["num_members"]
      topic = channel["topic"]["value"]
      Channel.new(slack_id: slack_id, name: name, member_count: member_count, topic: topic)
    end
    
    return channels
  end

end