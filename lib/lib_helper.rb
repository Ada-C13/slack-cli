require 'HTTParty'
require 'dotenv'
Dotenv.load

API_KEY = ENV['SLACK_TOKEN']
BASE_URL = 	'https://slack.com/api'
QUERY_PARAM = {
  token: API_KEY
}

require_relative 'workspace.rb'
require_relative 'channel.rb'
require_relative 'recipient.rb'
require_relative 'user.rb'