#require_relative 'workspace.rb'

require 'httparty'
require 'dotenv'
require 'table_print'

Dotenv.load

class SearchError < StandardError; end

module SlackCLI
  class Recipient
    attr_reader :slack_id

    BASE_URL = "https://slack.com/api/"
    POST_URL = "https://slack.com/api/chat.postMessage"
    SLACK_TOKEN = ENV["OAuth"]

    def initialize(slack_id)
      @slack_id = slack_id
    end

    def self.get_response(endpoint)
      response = HTTParty.get(BASE_URL + endpoint, query: {token: SLACK_TOKEN})

      if !response["ok"] || response["ok"] == "ok"
        raise SearchError, "Endpoint error: #{endpoint} is invalid"
      end

      return response
    end

    def self.send_message(message)
      return message
    end
  end
end
