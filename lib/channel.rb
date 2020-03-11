class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize
    @topic = topic
    @member_count = member_count
  end

  def details
  end

    # When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.

  def self.list_all
  end

end