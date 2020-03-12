require 'httparty'
require 'dotenv'

Dotenv.load 
TOKEN = ENV["SLACK_API_TOKEN"]
BASE_URL = "https://slack.com/api/"

class SlackAPIError < StandardError
end 

module SlackCli
  class Recipient

    attr_reader :slack_id, :name

    def initialize(slack_id,name)
      @slack_id = slack_id
      @name = name 
    end

    def self.get_all
    end 

    def send_msg(message)
      resp = HTTParty.post(POST_URL, {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          token: TOKEN,
          channel: self.slack_id,
          text: message
        }
      })
      return resp.code == 200 && resp.parsed_response["ok"]
    end

    def show_details
      return self.inspect
    end 


  end
end 