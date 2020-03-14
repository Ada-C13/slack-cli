require 'httparty'
require 'dotenv'
Dotenv.load
require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(topic:, member_count:, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic || {}
    @member_count = member_count
  end
  
  def details
    
  end

  def self.list_all

    response = Channel.get("https://slack.com/api/channels.list")
    
    all_channel_array = []
   
    response["channels"].each do |channel|
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]
      slack_id = channel["id"]
      name = channel["name"]
      new_channel = Channel.new(topic: topic, member_count: member_count, slack_id: slack_id, name: name)
      all_channel_array << new_channel
    end

    return all_channel_array
   
  end


end



