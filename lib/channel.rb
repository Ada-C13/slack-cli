
require 'dotenv'
require 'httparty'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"
SLACK_TOKEN = ENV["SLACK_TOKEN"]

class User

  
  def details(each)
  #
  end

  def self.list_all(each)
  #
  end
end