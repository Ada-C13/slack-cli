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
      details = "\nThe channel with name #{self.name.capitalize} and Slack ID #{self.slack_id} is described as '#{self.topic}'. "
      details += "There are #{self.member_count} members in this channel."
    end

    def self.list_all
      response = self.get(BASE_URL, query: {token: ENV["SLACK_TOKEN"]})
      channels = []
      response["channels"].each do |channel|
        channels << self.new(channel)
      end
      return channels
    end
  end
end