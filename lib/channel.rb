require_relative "recipient"

class Channel < Recipient 
  attr_reader :topic, :member_count

  def initialize( topic:, member_count:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end

  # displays channels details to command line
  def details
    tp self, "slack_id", "name", "topic", "member_count"
  end

  # gathers relevant information about channels in this workspace
  def self.list_all
    data = self.get("https://slack.com/api/conversations.list")

    channel_info = []

    data["channels"].each do |item|
      channel_info << Channel.new(
                        name: item["name"],
                        slack_id: item["id"], 
                        topic: item["topic"]["value"], 
                        member_count: item["num_members"]
      )
    end 

    return channel_info
  end

end 
