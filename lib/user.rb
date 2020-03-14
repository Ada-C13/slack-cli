require_relative "recipient"

USER_URL = "https://slack.com/api/users.list"

module Slack
  class User < Recipient
    attr_reader :real_name

    def initialize(slack_id:, name:, real_name:)
      super(slack_id: id, name: name)
      @real_name = real_name
    end

    def self.list
      response = self.get(USER_URL) # only needs url
      users = []
      response["members"].each do |user|
        users << self.new(
          slack_id: user["id"],
          name: user["name"],
          real_name: user["real_name"],
        )
      end
      return users
    end

    def details
    end
  end
end
