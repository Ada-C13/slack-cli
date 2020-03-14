require 'httparty'
require "dotenv"

Dotenv.load 
module SlackApp
  class Recipient
    
    API_KEY = ENV["SLACK_TOKEN"]
    
    attr_reader :slack_id, :name 
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name 
    end 
    
    def send_message(message)
    end 
    
    def self.get(url)
      puts "API KEY: #{API_KEY}"
      response = HTTParty.get(url, query: {token: API_KEY})
      
      if response.code != 200 || response["ok"] == false
        raise SlackAPIError, "There is a problem: #{response["error"]}"
      end
      
      return response
    end
    
    def self.list_all
      raise NotImplementedError, "Define this method in a child class please"
    end
    
    
    
  end 
end 


class SlackAPIError < Exception
end



