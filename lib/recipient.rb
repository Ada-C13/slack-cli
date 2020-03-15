require 'httparty'

class Recipient
  attr_reader :slack_id, :name 

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    HTTParty.post("https://slack.com/api/chat.postMessage", {
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
      body: {
        token: ENV["SLACK_TOKEN"],
        channel: @slack_id,
        text: message
      }
    })
  end

  def self.get(url)
    response = HTTParty.get(url, query: {token: ENV["SLACK_TOKEN"]})

    # checking for errors
    if response.code != 200 || response["ok"] == false 
      raise SlackApiError.new("The problem is: #{response["error"]}")
    end

    return response
  end
end

class SlackApiError < Exception
end
