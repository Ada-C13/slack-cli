require 'httparty'
require 'dotenv'
require_relative 'constants'

Dotenv.load 

module Slack 
  class Recipient 

    MESSAGE_URL = "https://slack.com/api/chat.postMessage"
    SLACK_TOKEN = ENV["SLACK_TOKEN"]

    attr_reader :slack_id, :name 

    def initialize(slack_id: , name:)
      @slack_id = slack_id 
      @name = name 
    end 

    def send_message(message)
    end 

    def self.get(url, params)
      response = HTTParty.get(url, query: params)

      if response["ok"] == false 
        raise ArgumentError, "We failed to get information from API"
      end 

      response_data = JSON.parse(response.body)

      return response_data
    end 

    def details 
      raise NotImplementedError, 'Implement me in a child class!'
    end  

    def self.list_all 
      raise NotImplementedError, 'Implement me in a child class!'
    end 
  end 
end 