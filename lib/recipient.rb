require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
	class SlackAPIError < NoMethodError

	end

	class Recipient

		attr_reader :slack_id, :name

		BASE_URL = "https://slack.com/api/"
		SLACK_TOKEN = ENV["SLACK_TOKEN"]
		
		def initialize(slack_id, name)
			@slack_id = slack_id
			@name = name
		end

		# Query for information.
		def self.get_response(endpoint)
			return HTTParty.get(BASE_URL + endpoint, query: {token: SLACK_TOKEN})
		end

		# Send a message.
		def self.send_message(message, selected)
			response = HTTParty.post(BASE_URL + "/chat.postMessage", {
				headers: { 
					'Content-Type' => 'application/x-www-form-urlencoded',
					'charset' => 'utf-8'
				},
				body: {
					token: SLACK_TOKEN,
					channel: selected.slack_id,
					text: message
				}
			})
			if (response.code == 200) && (response.parsed_response["ok"] == true)
				return true
			elsif (response.code == 200) && (response.parsed_response["ok"] == false)
				raise SlackAPIError.new("Invalid request.")
			end
		end
	end
end