require_relative 'recipient'

module Slack 
  class Channel < Recipient

    CHANNEL_URL = "https://slack.com/api/channels.list"

    SLACK_TOKEN = {
      token: ENV["SLACK_TOKEN"]
    } 

    attr_reader :slack_id, :name, :topic, :member_count 

    def initialize(topic:, member_count:, **args) 
      super(**args)
      @topic = topic 
      @member_count = member_count
    end 


    def details 
      return {
        :slack_id => @slack_id,
        :name => @name, 
        :topic => @topic, 
        :member_count => @member_count
      }
    end 
    

    def self.list_all 
      response_data = self.get(CHANNEL_URL, SLACK_TOKEN)

      channels = response_data["channels"]

      return channels.map do |info|
        slack_id = info["id"]
        name = info["name"]
        topic = info["topic"]["value"]
        member_count = info["num_members"]

        self.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)
      end 
    end 
  end 
end 