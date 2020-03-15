require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/"
TOKEN = ENV["SLACK_TOKEN"]
QUERY = {
  token: TOKEN,
  pretty: 1
}

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    response = HTTParty.post(BASE_URL + "chat.postMessage", {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      query: {
        token: TOKEN,
        channel: @slack_id,
        text: message
      }
    })
        
    if response.code == 200 && response.parsed_response["ok"]
      return true
    else
      raise SlackApiError, "We encountered a problem: #{response["error"]}"
    end
  end

  def self.get(endpoint)
    response = HTTParty.get(BASE_URL + endpoint, query: QUERY)
    if response.code != 200 || response["ok"] == false
      raise SlackApiError, "We encountered a problem: #{response["error"]}"
    else
      return response
    end
  end

  def details
    # implement in child class
  end

  def self.list_all
    # implement in child class
  end
end

class SlackApiError < Exception
end