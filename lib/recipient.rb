require 'httparty'
require 'dotenv'
Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)
    params = {
      token: ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(url, query: params)
    raise Exception if response.code != 200
    return response
  end

  def send_message(message)
    puts "#{message} #{slack_id}"
    url = "https://slack.com/api/chat.postMessage"
    params = {
      token: ENV["SLACK_TOKEN"],
      channel: slack_id,
      text: message
    }

    response = HTTParty.post(url, query: params)
    raise Exception if response.code != 200
    return response
  end
end
