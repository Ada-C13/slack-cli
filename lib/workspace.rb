require_relative 'recipient'
require_relative 'user'

require 'httparty'
require 'dotenv'

Dotenv.load

class Workspace

	attr_reader :users, :channels

	BASE_URL = "https://slack.com/api/"
	SLACK_TOKEN = ENV["SLACK_TOKEN"]

	def initialize
		@users = []
		@channels = []
	end

	def load_users
		response = HTTParty.get(BASE_URL + "users.list", query: {token: SLACK_TOKEN})

		response["members"].each do |member|
			username = member["name"]
			real_name = member["profile"]["real_name"]
			slack_id = member["id"]

			self.users << User.new(username, real_name, slack_id)
		end

	end
end