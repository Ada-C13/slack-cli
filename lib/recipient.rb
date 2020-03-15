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
      response = HTTParty.post("https://slack.com/api/chat.postMessage", {
        query: {'Content-Type' => 'application/json'},
        body: {
          token: API_KEY,
          channel: self.slack_id,
          text: message 
        }
        
        })
        if response.code != 200 || response["ok"] == false
          raise SlackAPIError, "We encountered a problem: #{response["error"]}"
        end
      end 
      
      def self.get(url)
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
  
  
  
  