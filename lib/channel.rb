require_relative 'recipient'

class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count

  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end

  def details
    tp self, "slack_id", "name", "topic", "member_count"
  end

  def self.list_all
    #list all of the channels in this workspace
    url = "https://slack.com/api/conversations.list"

    response = Channel.get(url)

    channels = response["channels"].map do |c|
      Channel.new(
        slack_id: c["id"],
        name: c["name"],
        topic: c["topic"]["value"],
        member_count: c["num_members"]
      )
    end
    return channels
  end
end

