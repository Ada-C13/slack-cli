require 'httparty'
require 'awesome_print'
require 'dotenv'

class Recipient
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  
  # fetcher method based on the API's docs
  def self.get(url)
    #send message using HTTParty
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

    #check for errors
    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
    return response
  end


  # template method 
  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end

  
  def send_message(message, selected)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.post(
      url, 
      headers: { 
        'Content-Type'=> 'application/x-www-form-urlencoded',
        'charset' => 'utf-8' 
      },
      body:{
        token: ENV["SLACK_TOKEN"],
        channel: selected.id,
        text: message
      }
    )
    
    # if we can't get the right response from API call, then raise argument
    unless response.code == 200 && response.parsed_response["ok"] 
      raise SlackAPIError, "Message cannot be sent"
    end

    return true
  end
end

class SlackAPIError < Exception
end