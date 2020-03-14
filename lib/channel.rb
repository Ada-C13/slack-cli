require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(topic: nil, member_count: nil, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic || {}
    @member_count = member_count || []
  end

  # def details 
  # end

  def self.list_all
    response = Channel.get("https://slack.com/api/channels.list")
    channels = []

    response["channels"].each do |item|
      channels << Channel.new(
        topic: item["topic"],
        member_count: item["member_count"],
        slack_id: item["id"], 
        name: item["name"]
      )
    end
    return channels
  end
end

  