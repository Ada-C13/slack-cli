require_relative 'workspace'

require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
	class Recipient

		attr_reader :slack_id

		BASE_URL = "https://slack.com/api/"
		SLACK_TOKEN = ENV["SLACK_TOKEN"]
		
		def initialize(slack_id)
			@slack_id = slack_id
		end

		def self.get_response(endpoint)
			return HTTParty.get(BASE_URL + endpoint, query: {token: SLACK_TOKEN})
		end
	end
end