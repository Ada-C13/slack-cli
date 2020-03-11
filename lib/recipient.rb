require 'httparty'
require 'dotenv'

Dotenv.load 
TOKEN = ENV["SLACK_API_TOKEN"]
BASE_URL = "https://slack.com/api/"

module SlackCli
  
  class Recipient

    attr_reader :slack_id, :name

    def initialize(slack_id,name)
      @slack_id = slack_id
      @name = name 
    end

    def self.get_all
    end 

  end
end 