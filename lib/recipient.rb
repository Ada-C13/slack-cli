require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

POST_URL = "https://slack.com/api/chat.postMessage"

class Recipient
  
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name  
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.get(url) 
    response = HTTParty.get(url, query: {token: ENV["SLACK_TOKEN"]})
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError.new("We encounter a problem (got #{response["error"]})")
    else 
      return response
    end
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def send_message(message) #string
    response = HTTParty.post(
      POST_URL, 
      query: {
        token: ENV["SLACK_TOKEN"],
        channel: @slack_id,
        text: message,
        as_user: true,
        }
       )
  end
end



class SlackAPIError < Exception
end