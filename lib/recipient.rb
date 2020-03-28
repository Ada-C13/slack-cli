require 'httparty'

class Recipient
  
  attr_reader :slack_id, :name
  
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end
  
  def send_message(message)
    #send message using HTTParty
    response = HTTParty.post("https://slack.com/api/chat.postMessage", body: {token: ENV['SLACK_TOKEN'], text: message, channel: @slack_id})
    if response.code != 200 || response['ok'] == false
      raise SlackAPIError
    end
    
    return true
    
  end
  
  def self.get(url)
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})
    if response.code != 200 || response['ok'] == false
      raise SlackAPIError
    end
    
    return response
    
  end
  
  # def self.list_all
  # end
  
  
end

class SlackAPIError < Exception
end