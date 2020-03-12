require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

class Channel < Recipient
  attr_reader :topic, :member_count

  CHANNELS_URI = "https://slack.com/api/conversations.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  
  def self.list_all
    response = Channel.get(CHANNELS_URI,{token: SLACK_TOKEN})
   
    all_channels = response["channels"].map do |channel|
      sleep(0.5)
      self.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])    
    end

    return all_channels
  end

  def get_details
    tp self, :slack_id, :name, :topic, :member_count
    return true
  end
end

   # name, topic, member count, and Slack ID
