require 'dotenv'
require 'httparty'

Dotenv.load

BASE_URL = "https://slack.com/api/"
SLACK_TOKEN = ENV["SLACK_TOKEN"]
POST_URL = "#{BASE_URL}/users.list"

def test_url
  response = HTTParty.get("#{BASE_URL}?token=#{SLACK_TOKEN}")
  response_data = JSON.parse(response.body)
  print response_data
end

puts test_url

class User
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:)
  end

  def details(each)
    #
  end

  def self.list_all
    #
  end
end
