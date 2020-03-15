require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    params = {
      token: ENV["SLACK_TOKEN"],
      channel: slack_id,
      text: message
    }

    response = HTTParty.post("https://slack.com/api/chat.postMessage", query: params)
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
    return response
  end

  def self.get(url)
    params = {
      token: ENV["SLACK_TOKEN"]
    }
    data = HTTParty.get(url, query: params)
    if data.code != 200 || data["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{data["error"]}"
    end

    return data
  end

  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end
end

class SlackAPIError < Exception
end
