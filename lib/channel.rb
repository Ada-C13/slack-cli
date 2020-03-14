require 'httparty'
require 'dotenv'
Dotenv.load
require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(topic:, member_count:)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    
  end

  def self.list_all

    response = Channel.get("https://slack.com/api/channels.list")

    channel_output_array = []
   
    response["channels"].each do |channel|
      channel_output = {}
      channel_output["Channel Name"] = channel["name"]
      channel_output["Channel Topic"] = channel["topic"]
      channel_output["Member Count"] = channel["members"].count
      channel_output["Slack ID"] = channel["id"]
      channel_output_array << channel_output
    end
    return channel_output_array
   
  end


end
