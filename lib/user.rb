require 'httparty'
require 'colorized'

module SlackCLI
  class User < Recipient
    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

    BASE_URL = "https://slack.com/api/users.list"

    def initialize(data)
      super(slack_id: data['id'], name: data['name'])
      @real_name = data['real_name']
      @status_text = data['profile']['status_text']
      @status_emoji = data['profile']['status_emoji']
    end

    def details
      details = "\nThe slack user with username #{self.name} and Slack ID #{self.slack_id} is named #{self.real_name}. "
      unless self.status_text == '' || self.status_emoji == ''
        details += "Their status is '#{self.status_text}' and their status emoji is #{self.status_emoji}."
      end
      return details
    end

    def self.list_all
      response = self.get(BASE_URL, query: {token: ENV["SLACK_TOKEN"]})
      users = []
      response["members"].each do |member|
        users << self.new(member)
      end
      return users  
    end
  end
end