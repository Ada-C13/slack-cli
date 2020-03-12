require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(name, slack_id, topic, member_count)
    super(name, slack_id)
    @topic = topic
    @member_count = member_count
  end

  def self.list_all
    response = Channel.get("https://slack.com/api/conversations.list")
    channel_list = response["channels"].map do |channel|
      Channel.new(
        name = channel["name"],
        slack_id = channel["id"],
        topic = channel["topic"]["value"],
        member_count = channel["num_members"]
      )
    end

    return channel_list
  end

  def details
    return "Channel name: #{name}\nSlack ID: #{slack_id}\nChannel topic: #{topic}\nMember count: #{member_count}"
  end

end
