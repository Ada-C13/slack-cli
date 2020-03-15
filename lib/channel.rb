require "httparty"
require "awesome_print"
require_relative "recipient"

CHANNEL_LIST_URL = "https://slack.com/api/conversations.list"
POST_URL = "https://slack.com/api/chat.postMessage"

class Channel < Recipient
  
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list_all
    response = self.get(CHANNEL_LIST_URL)

    channel_lists = response["channels"].map do |channel|
       Channel.new(
        channel["id"], 
        channel["name"], 
        channel["topic"], 
        channel["num_members"]
       )
    end
    return channel_lists
  end

  def details
    return "Slack ID: #{@slack_id}\nName: #{@name}\nTopic: #{@topic}\nMember Count: #{@member_count}"
  end
end
