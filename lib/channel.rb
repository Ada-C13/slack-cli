require_relative 'recipient'
require "httparty"

module Slack_cli
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(id:, name:, topic:, member_count:)
      super(id: id, name: name)

      @topic = topic
      @member_count = member_count 
    end

    def details
      tp self, "id", "name", "topic", "member_count"
    end

    private
    # Get all the channels from Slack API.
    # For each channel it creates an intance of channel.
    def self.list_all

      channels = []
      
      base_url = "https://slack.com/api/"
      post_url = "#{base_url}channels.list"
      params = { token: ENV["SLACK_API_TOKEN"] }

      response = get(post_url, params)

      response["channels"].each do |channel|
        channels << new(
          id: channel["id"], 
          name: channel["name"], 
          topic: channel["topic"]["value"], 
          member_count: channel["num_members"]
        )
      end
      return channels
    end
  end
end
#  p Slack_cli::Channel.list_all
# # a = Channel.new(id: 1, name: "name", topic: "s", member_count: 1)
# # p a