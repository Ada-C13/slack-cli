require 'pry'
require 'httparty'

module SlackCLI
  class User < Recipient
    attr_reader :slack_id, :name, :real_name

    BASE_URL = "https://slack.com/api/users.list"

    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
      # @status_text = status_text
      # @status_emoji = status_emoji
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
      users = []
      response["members"].each do |member|
        users << self.new(slack_id: member['id'], name: member['name'], real_name: member['real_name'])
      end
      return users
    end
  end
end