
# require 'table_print'
require 'httparty'
require 'dotenv'
Dotenv.load

BASE_URL = 'https://slack.com/api/'
PARAMS = {
  token: ENV['SLACK_TOKEN'],
  pretty: 1
}

class Recipient
  attr_reader :slack_id, :nickname
  def initialize(slack_id:, nickname:)
    @slack_id = slack_id
    @nickname = nickname
  end

  def details
    return "here are the details for this #{self.class}:\nID: #{slack_id}\nnickname: #{nickname}" 
  end

  def send_message(message)
    response = HTTParty.post(
      "#{BASE_URL}/chat.postMessage",
      body:  {
        token: ENV['SLACK_TOKEN'],
        text: message,
        # how can I specify that the channel is the selected from in workspace (can it be a user?)
        channel: @slack_id
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )

    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackAPIError, "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
    end

    return true
  end

  def self.get(endpoint, params)
    data = HTTParty.get(endpoint, query: params)

    if data.code != 200 || data["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{data["error"]}"
    end

    return  data
  end

  class << self

    def endpoint
    end

    def response_root
    end

    def make_from_record(record)
    end

    def list_all
      response = self.get(BASE_URL + endpoint, PARAMS)
      all = []
      (response[response_root]).each do |record|
        all << make_from_record(record)
      end
      return all
    end
  end

end

class SlackAPIError < Exception
end