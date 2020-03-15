require 'httparty'
require_relative 'recipient'

module SlackCli
  class Channel < Recipient
    attr_accessor :topic, :member_count

    def initialize(id, name, topic, member_count)
      super(id, name)
      @topic = topic
      @member_count = member_count
    end #initialize

    #--------Channel Class Methods----------------------------

    #retrieves list of channels from Slack
    #input
    #returns list of channels [Channel]
    def self.load_all(url)
      channels = []
      #send request to Slack API using users.list endpoint
      response = HTTParty.get(url) #request that will return the response
      #parse response and get users
        response['channels'].each do |channel|
          id = channel["id"]
          name = channel["name"]
          topic = channel["topic"]["value"]
          member_count = channel["num_members"]
          # member_count = channel["members"].length
          #create a channel
          slack_channel = SlackCli::Channel.new(id, name, topic, member_count)
          #save to channels
          channels.push(slack_channel)
        end
      return channels
    end #load_all method


  end #class
end #module

# testchannels = SlackCli::Channel.load_all
# testchannels.each do |channel|
#   puts channel.id
#   puts channel.name
#   puts channel.topic
#   puts channel.member_count
# end