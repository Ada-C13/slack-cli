require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list_channels
    # instead of Recipient or Channel, can just say self so that in case it changed elsewhere it wouldn't matter.
    response = self.get_all("channels.list")

    channel_list = []
    if response["ok"] != true
      raise SlackAPIError, "Oops! An error has occurred: #{response["error"]}"
    else
      response["channels"].each do |channel|
        @slack_id = channel["id"]
        @name = channel["name"]
        @topic = channel["topic"]["value"]
        @member_count = channel["num_members"]

        channel_list << Channel.new(@slack_id, @name, @topic, @member_count)
      end
    end

    return channel_list
  end

  def details
    # IMPLEMENT SHOW DETAILS IN CHANNEL CLASS
  end
end
