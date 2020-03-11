require 'httparty'
require 'dotenv'
Dotenv.load 

SLACK_URL = "https://slack.com/api/conversations.list"
TOKEN = ENV["SLACK_API_TOKEN"]

class Recipient

  attr_reader :slack_id

  def initialize
    @slack_id = HTTParty.get(SLACK_URL,query: {token: TOKEN})["channels"][0]["id"]
  end


  def details
  end 

end