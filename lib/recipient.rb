require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/"
QUERY = {
  token: ENV["SLACK_TOKEN"],
  pretty: 1
}

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    # response
    # send a message
  end

  # Recipient.get("conservations.list", QUERY)

  def self.get(endpoint)
    response = HTTParty.get(BASE_URL + endpoint, query: QUERY)
    if response.code != 200 || response["ok"] == false
      raise SlackApiError, "We encountered a problem: #{response["error"]}"
    end

    return response
  end


  def details
  end

  def self.list_all
    # abstract method
    # endpoint = ""
    # if self == User
    #   endpoint = "users.list"
    # elsif self == Channel
    #   endpoint = "conversations.list"
    # end

    # response = User.get(endpoint, QUERY)
    # all = []

  end
end

class SlackApiError < Exception
end