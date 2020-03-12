require "httparty"
require "dotenv"
Dotenv.load
AUTH_TOKEN = ENV["SLACK_TOKEN"]

class Recipient
  attr_reader :name, :slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end


  def send_message(channel, message)
    url = "https://slack.com/api/chat.postMessage"
    query = {
      token: AUTH_TOKEN,
      channel: channel,
      text: message,
    }
    response = HTTParty.post(url, query: query)
    raise(Exception, "Failed to send your message") if response["true"] == false 
  end

  private

  def self.get(base_url)
    query = {
      token: AUTH_TOKEN,
    }
    response = HTTParty.get(base_url, query: query)
    raise(Exception, "Failed to access API, check url") if response["okay"] == false
    return response
  end

  def self.list_all
    raise(NotImplementedError, "Implement me in a child class!")
  end

end
