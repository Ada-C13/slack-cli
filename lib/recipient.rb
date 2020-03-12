require_relative 'workspace.rb'

require 'httparty'
require 'dotenv'
require 'table_print'

Dotenv.load

module SlackCLI
  class Recipient
    attr_reader :slack_id

    BASE_URL = "https://slack.com/api/"
    SLACK_TOKEN = ENV["OAuth"]

    def initialize(slack_id)
      @slack_id = slack_id
    end

    def self.get_response(endpoint)
      HTTParty.get(BASE_URL + endpoint, query: {token: SLACK_TOKEN})
    end

    def send_message(message)
    
    end

    def details
      
    end
  end
end
