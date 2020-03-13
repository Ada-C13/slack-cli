require_relative 'recipient'
require "httparty"

module Slack_cli
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji

    def initialize(id:, name:, real_name:, status_text:, status_emoji:)
      super(id: id, name: name)

      @real_name = real_name
      @status_text = status_text 
      @status_emoji = status_emoji
    end

    private

    # Get all the users from Slack API.
    # For each list_all creates an intance of channel.
    def self.list_all

      users = []
      
      base_url = "https://slack.com/api/"
      post_url = "#{base_url}users.list"
      params = { token: ENV["SLACK_API_TOKEN"] }

      response = get(post_url, params)

      response["members"].each do |user|
        users << new(
          id: user["id"], 
          name: user["name"], 
          real_name: user["real_name"],
          status_text: user["profile"]["status_text"], 
          status_emoji: user["profile"]["status_emoji"]
        )
      end
      return users
    end
  end 
end

# p Slack_cli::User.list_all