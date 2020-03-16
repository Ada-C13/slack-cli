require_relative "recipient"

# BASE_URL = "https://slack.com/api/conversations.list"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(name:, slack_id:, topic:, member_count:)
    super(name: name, slack_id: slack_id)
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list_all
    data = Channel.get("https://slack.com/api/conversations.list")
    channels = data["channels"].map do |channel|
      self.new(
        name: channel["name"],
        slack_id: channel["id"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"]
      )
    end
  end
end
