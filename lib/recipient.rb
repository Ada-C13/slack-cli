require 'httparty'

class Recipient
  attr_reader :slack_id, :name
  #parent to channel and user classes
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)
    q = {
      token: ENV['TOKEN']
    }
    response = HTTParty.get(url, query: q)

    if !response["ok"]
      raise ArgumentError, "#{response["error"]}"
    else
      return response
    end
  end

  def send_message(message)
    #do some httparty posting shiz
    url = "https://slack.com/api/chat.postMessage"
    q = {
      token: ENV['TOKEN'],
      channel: self.slack_id,
      text: message
    }
    response = HTTParty.post(url, q)

    if !response["ok"]
      raise ArgumentError, "Unable to post: #{response["error"]}"
    end
  end

  def details
    #see child classes
  end

  def self.list_all
    #see child classes
  end
end

