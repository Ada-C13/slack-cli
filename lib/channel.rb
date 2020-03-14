require_relative 'recipient'

class Channel < Recipient

  attr_reader :member_count, :topic

  def initialize(member_count:, topic:, name:, slack_id:)
    super(name: name, slack_id: slack_id)
    
    @member_count = member_count
    @topic = topic
  end

  def details
  end

  # =====Class methods=====
  def self.list_all

    response = Channel.get("https://slack.com/api/channels.list")

    # parsing the data

    
    channels = response["channels"].map do |item|
      Channel.new(
        member_count: (item["members"]).length,
        topic: item["topic"]["value"],
        name: item["name"],
        slack_id: item["id"],
      )
    end

    return channels
  end
end