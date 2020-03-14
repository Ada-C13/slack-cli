require_relative "recipient"

CHANNEL_URL = "https://slack.com/api/conversations.list"

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def self.list
      response = self.get(CHANNEL_URL)
      channels = []
      response["channels"].each do |channel|
        channels << self.new(
          slack_id: channel["id"],
          name: channel["name"],
          topic: channel["topic"],
          member_count: channel["num_members"],
        )
      end
      return channels
    end

    def details
    end
  end
end
