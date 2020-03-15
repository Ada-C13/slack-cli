require 'pry'
require 'httparty'

module SlackCLI
  class Recipient

    BASE_URL = "https://slack.com/api/"
    class SlackAPIError < StandardError; end

    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url, params)
      response = HTTParty.get(url, params)
      unless response.code == 200 && response["ok"]
        raise SlackAPIError.new("Slack API call failed with reason: #{response['error']}")
      end
      return response 
    end

    def send_message(message)
      resp = HTTParty.post("#{BASE_URL}chat.postMessage",
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded'
        },
        body: {
          token: ENV["SLACK_TOKEN"],
          channel: @slack_id,
          text: message
        }
      )
      unless response.code == 200 && response["ok"]
        raise SlackAPIError.new("Slack API call failed with reason: #{resp['error']}")
      end
      return true
    end

    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.list_all
      raise NotImplementedError, 'Implement me in a child class!'
    end
  end
end
