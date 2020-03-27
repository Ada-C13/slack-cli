require 'table_print'
require 'ap'
require 'HTTParty'
require 'dotenv'
Dotenv.load
Dotenv.require_keys("SLACK_TOKEN")

API_KEY = ENV['SLACK_TOKEN']
BASE_URL = 	'https://slack.com/api/'
QUERY_PARAM = {
  token: API_KEY
}

require_relative "channel.rb"
require_relative "user.rb"