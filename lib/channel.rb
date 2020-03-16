require_relative 'recipient.rb'
require 'dotenv'
require 'httparty'

Dotenv.load

class Channel < Recipient
  attr_reader :slack_id, :topic, :member_count, :name
  def initialize(slack_id:, name:, topic:, member_count:)
    @slack_id = slack_id 
    @topic = topic
    @member_count = member_count
    @name = name
  end

  def details
    return [{"name" => @name, "slack_id" => @slack_id, "topic" => @topic, "member_count" => @member_count}]
    # return self, "slack_id", "name", "topic", "member_count"
  end

  def self.list_all
    url = "https://slack.com/api/channels.list"
    params = {
        token: ENV['SLACK_TOKEN'],
      }
      response = self.get(url,params)
      array_of_channels = []
      response["channels"].each do |channel|
        array_of_channels.push(Channel.new(slack_id: channel["id"], name: channel["name"], topic: channel["topic"]["value"], member_count: channel["members"].length))
      end

    return array_of_channels
  end 

end