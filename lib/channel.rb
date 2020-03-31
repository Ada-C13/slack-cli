require_relative "recipient"

class Channel < Recipient

  attr_reader :topic, :member_count

  def initialize(topic:, member_count:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end

  def details
    tp self, "slack_id", "name", "topic", "member_count"
  end

  #------ Class Methods ------

  def self.list_all
    response = Channel.get("https://slack.com/api/channels.list")

    channels = []

    response["channels"].each do |item|
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