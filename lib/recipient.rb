# require gems
require "httparty"
RECIPIENT_URL = "https://slack.com/api/chat.postMessage"
class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    response = HTTParty.post("#{RECIPIENT_URL}?token=#{ENV['SLACK_TOKEN']}", {
      body: {
        text: message,
        channel: slack_id
      }
    })
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}" 
    else
      puts "Your message was sent!"
    end
  end

  def self.get(url)
    # how to get(api lecture)/ what will it return
    # error handling
    #send message using HTTParty
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})
      raise SlackAPIError, "We encountered a problem: #{response["error"]}" if response.code != 200 || response["ok"] == false
  return response
  end

  def details
    raise NotImplementedError, "Template method"
  end
  def self.list_all
    # error handling
    raise NotImplementedError, "Template method"
  end
end

class SlackAPIError < Exception
end