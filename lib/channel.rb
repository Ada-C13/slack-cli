require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'


Dotenv.load

class Channel < Recipient
  attr_reader :topic, :members

  BASE_URL = "https://slack.com/api/channels.list?"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]


  def initialize(id, name, topic, members)
    super(id, name)
    @topic = topic
    @members = members
    
  end

  def self.list_all

    query = {
     token: SLACK_TOKEN, 
   }
  
    response = HTTParty.get(BASE_URL, query: query)
    channel_list = []
  
    response["channels"].each do |channel|
      name = channel["name"]
      id = channel["id"]
      topic = channel["topic"]["value"]
      members = channel["members"].length
      channel_list << Channel.new(id, name, topic, members)
    end
    return channel_list
  end
 
end

