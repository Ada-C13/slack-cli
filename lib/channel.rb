require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCli

  class Channel < Recipient

    attr_reader :slack_id, :name, :topic, :member_count

    def initialize (slack_id:, name:, topic:, member_count:)
        super(slack_id, name)
        @topic = topic
        @member_count = member_count
    end
    
    def details
        return [{"slack_id" => slack_id,"name" => name,"topic" => topic, "member_count" => member_count }]
    end

    def self.create_a_channel(channel_name)
        url = "https://slack.com/api/channels.create"
        param = {token: ENV["SLACK_BOT_TOKEN"],name: channel_name}
        new_channel = HTTParty.post(url, query: param)
        return new_channel.code
    end

    def self.list_all
        url = "https://slack.com/api/conversations.list"
        param = {token: ENV["SLACK_API_TOKEN"]}
        result = self.get(url, param)
        channel_list = result["channels"].map { |channel| SlackCli::Channel.new(slack_id: channel["id"], name: channel["name"], topic: channel["topic"]["value"], member_count: channel["num_members"]) }
        return channel_list
    end

  end
end