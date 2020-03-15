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

  # Class Methods ---------

  def self.list_channels
    # instead of Recipient or Channel, can just say self so that in case it changed elsewhere it wouldn't matter.
    retrieved_response = self.get_all("channels.list")

    channel_list = []
    retrieved_response["channels"].each do |channel|
      @slack_id = channel["id"]
      @name = channel["name"]
      @topic = channel["topic"]["value"]
      @member_count = channel["num_members"]

      channel_list << Channel.new(@slack_id, @name, @topic, @member_count)
    end

    return channel_list
  end
end