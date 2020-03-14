require "httparty"
require "awesome_print"
require_relative "recipient"

CHANNEL_LIST_URL = "https://slack.com/api/conversations.list"

class Channel < Recipient
  
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list_all
    response = self.get(CHANNEL_LIST_URL)

    channel_lists = []
    response["channels"].each do |channel|
       channel_lists << self.details(channel)
    end
    return channel_lists
  end

  def self.details(channel) #hash
    return Channel.new(
      slack_id = channel["id"],
      name = channel["name"],
      topic = channel["topic"],
      member_count = channel["num_members"]
    )
  end
end

# ap Channel.list_all