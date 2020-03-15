require 'httparty'
require 'dotenv'

Dotenv.load 

module Slack 

  USER_URL = "https://slack.com/api/users.list"
  CHANNEL_URL = "https://slack.com/api/conversations.list"
  MESSAGE_URL = "https://slack.com/api/chat.postMessage"
  HISTORY_URL = "https://slack.com/api/conversations.history"
  SLACK_TOKEN = {
    token: ENV["SLACK_TOKEN"]
  }

  class Recipient 

    attr_reader :slack_id, :name 

    def initialize(slack_id: , name:)
      @slack_id = slack_id 
      @name = name 
    end 


    def send_message(text, selected)
      response = HTTParty.post(
        MESSAGE_URL,
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded'
        },
        body: {
          token: ENV["SLACK_TOKEN"],
          text: text,
          channel: selected.slack_id,
          username: "My Bot"
        }
      )

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "There is an error when posting #{text} to #{name}, error: #{response.parsed_response["error"]}"
      end 

      return true  
    end 


    def details 
      raise NotImplementedError, 'Implement me in a child class!'
    end 


    def self.get(url, params)
      response = HTTParty.get(url, query: params)

      # TO DO
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "We failed to get information from API"
      end 

      response_data = JSON.parse(response.body)

      return response_data
    end  


    def self.list_all 
      raise NotImplementedError, 'Implement me in a child class!'
    end 


    # def load_message_history 
    #   raise NotImplementedError, 'Implement me in a child class!'
    # end 
  end 
end 


class SlackApiError < StandardError; end