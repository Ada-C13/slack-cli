require 'pry'
require 'httparty'
require_relative 'recipient'

module SlackCLI
  class Channel < Recipient
    attr_reader :slack_id, :name, :topic, :member_count

    BASE_URL = "https://slack.com/api/conversations.list"
    SLACK_TOKEN = 

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def details
      # response = self.get(BASE_URL, {token: SLACK_TOKEN})
      # user = response['name']    
      # return user
    end

    def self.list_all
      response = self.get(BASE_URL, query: {token: ENV["SLACK_TOKEN"]})
      unless response["ok"]
        raise Exception.new(response["error"])
      end
      channels = []
      response["channels"].each do |channel|
        channels << self.new(
          slack_id: channel['id'], 
          name: channel['name'], 
          topic: channel['topic']['value'],
          member_count: channel['num_members']
        )
      end
      return channels
    end
  end
end