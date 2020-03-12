
require_relative 'recipient'
require 'httparty'
require 'dotenv'


class ChannelRecipient < Recipient 
  attr_reader :topic, :member_count 

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end 

  def details 
    pretty_string = "DETAILS:
    Slack ID: #{@slack_id}
    Name: #{@name}
    Topic: #{@topic}
    Member Count: #{@member_count}
    "
    return pretty_string
  end 

  def self.list_all
    query = {
      token: ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(BASE_URL + "conversations.list", query: query)
  
    channels = response["channels"]
    channels_array = []
    channels.each do |channel|
      channels_array << ChannelRecipient.new(channel["id"], channel["name"], channel["topic"], channel["num_members"])
    end 
    return channels_array
  end 

  def self.find(id)
    self.list_all.each do |channel|
      if id == channel.slack_id
        return channel
      end 
    end
    return "CHANNEL NOT FOUND"
  end 

  # def send_message(message)
  #   query = {
  #     token: ENV["SLACK_TOKEN"],
  #     text: message, 
  #     channel: @slack_id
  #   }
  #   response = HTTParty.post(BASE_URL + "chat.postMessage", query: query)
  # end 

end 