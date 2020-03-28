require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize(topic:, member_count:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end

  def details
    return details = "Slack ID: #{self.slack_id}, Name: #{self.name}, Topic: #{self.topic}, Member Count: #{self.member_count}"
  end

  def self.list_all
    
    data = self.get("https://slack.com/api/conversations.list")

    channels = []

    data["channels"].each do |item|
      channels << Channel.new(
        name: item["name"],
        slack_id: item["id"],
        topic: item["topic"]["value"],
        member_count: item["num_members"]
      )
      end

    return channels
  end
end