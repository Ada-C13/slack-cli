
require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class'
  end

  def self.get(url)
    response = HTTParty.get(url , query: {token: ENV["SLACK_TOKEN"]})
    
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encaunterd a problem #{response["error"]}"
    end
    return response
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end


  def send_message(msg)
    url = "https://slack.com/api/chat.postMessage"
    query = {token: ENV["SLACK_TOKEN"], channel: self.slack_id, text: msg}

    response = HTTParty.post(url, query: query)

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    else
      return true
    end
  end
end

class SlackAPIError < Exception
end
  
