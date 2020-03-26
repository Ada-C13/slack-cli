require_relative "recipient"
require "httparty"

Dotenv.load

module SlackCLI
  class User < Recipient
    BASE_URL = "https://slack.com/api/users.list?"
    attr_reader :channels, :name, :slack_id

    def initialize(name, slack_id, channels = [])
      super(slack_id: slack_id, name: name)
      @channels = channels
    end

    def print_details
      return { name: name, slack_id: slack_id, channels: channels }
    end

    def self.get_from_api
      query_parameters = {}
    end
  end
end
