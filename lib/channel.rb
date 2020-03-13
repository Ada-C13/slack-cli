require 'pry'
require 'httparty'
require_relative 'recipient'

module SlackCLI
  class Channel < Recipient
    attr_reader :slack_id, :name, :topic, :member_count

    BASE_URL = "https://slack.com/api/conversations.list"

    def initialize(data)
      super(slack_id: data['id'], name: data['name'])
      @topic = data['topic']['value']
      @member_count = data['num_members']
    end

    def details
      return self
    end

    def self.list_all
      response = self.get(BASE_URL, query: {token: ENV["SLACK_TOKEN"]})
      unless response["ok"]
        raise Exception.new(response["error"])
      end
      channels = []
      response["channels"].each do |channel|
        channels << self.new(channel)
      end
      return channels
    end
  end
end