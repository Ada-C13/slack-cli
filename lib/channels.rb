require_relative "recipient"
require "httparty"
require "dotenv"
require "table_print"

class Channel < Recipient
  attr_accessor :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  # called in the workspace
  def self.list_channels
    response = Recipient.get("channels.list")
    channel_list = []
    if response["ok"] != true
      raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
    else
      response["channels"].each do |channel|
        @slack_id = channel["id"]
        @name = channel["name"]
        @topic = channel["topic"]
        @member_count = channel["members"].length

        channel_list << Channel.new(@slack_id, @name, @topic, @member_count)
      end
    end
    return channel_list
  end
end

# def self.load_all()
#   channels = []
#   #send request to Slack API using users.list endpoint
#   #                               after?  param =    value
#   url = "https://slack.com/api/channels.list?token=#{ENV['SLACK_TOKEN']}" #https://github.com/bkeepers/dotenv
#   response = HTTParty.get(url) #request that will return the response
#   #parse response and get users
#     response['channels'].each do |channel|
#       id = channel["id"]
#       name = channel["name"]
#       topic = channel["topic"]["value"]
#       member_count = channel["num_members"]
#       # member_count = channel["members"].length
#       #create a channel
#       slack_channel = SlackCli::Channel.new(id, name, topic, member_count)
#       #save to channels
#       channels.push(slack_channel)
#     end
#   return channels
# end #load_all method
