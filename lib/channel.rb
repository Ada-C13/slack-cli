require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  @all_channels = []

  def initialize
    @topic = topic
    @member_count = member_count
  end

  def details
  end

    # When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.

  def self.list_all
    response = Channel.get("conversations.list", QUERY)
    all = []

    response["channels"].each do |channel|
      all << {
        name: channel["name"],
        id: channel["id"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"]
      } 
    end
    
    return all
  end

end