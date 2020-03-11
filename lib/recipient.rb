require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
	class Recipient

		attr_reader :slack_id, :name

		BASE_URL = "https://slack.com/api/"
		SLACK_TOKEN = ENV["SLACK_TOKEN"]
		
		def initialize(slack_id, name)
			@slack_id = slack_id
			@name = name
		end

		def self.get_response(endpoint)
			return HTTParty.get(BASE_URL + endpoint, query: {token: SLACK_TOKEN})
		end
	end
end