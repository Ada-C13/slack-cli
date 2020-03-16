require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    puts "The '#{@name}' channel has a slack id of #{@slack_id} and has #{@member_count} members. \n Channel topic/purpose: #{@topic}"
  end

  def self.list_channels
    retrieved_response = self.get_all("channels.list")

    channel_list = retrieved_response["channels"].map do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]

      Channel.new(slack_id, name, topic, member_count)
    end

    return channel_list
  end
end